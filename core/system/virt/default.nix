{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  qemu-anti-detection =
    (pkgs.qemu.override {
      hostCpuOnly = true;
    }).overrideAttrs
      (
        finalAttrs: previousAttrs: {
          # ref: https://github.com/zhaodice/qemu-anti-detection
          patches = (previousAttrs.patches or [ ]) ++ [
            # (pkgs.fetchpatch {
            #   url = "https://raw.githubusercontent.com/zhaodice/qemu-anti-detection/main/qemu-8.2.0.patch";
            #   sha256 = "sha256-RG4lkSWDVbaUb8lXm1ayxvG3yc1cFdMDP1V00DA1YQE=";
            # })
            ./patches/spoof.patch
          ];
          src = pkgs.fetchurl {
            url = "https://download.qemu.org/qemu-${finalAttrs.version}.tar.xz";
            hash = "sha256-73hvI5jLUYRgD2mu9NXWke/URXajz/QSbTjUxv7Id1k=";
          };
          # postFixup =
          #   (previousAttrs.postFixup or "")
          #   + "\n"
          #   + ''
          #     for i in $(find $out/bin -type f -executable); do
          #       mv $i "$i-anti-detection"
          #     done
          #   '';
          version = "10.0.2";
          # pname = "qemu-anti-detection";
        }
      );
  sys = config.modules.system.virtualization;
in
{
  config = mkIf (sys.enable) {
    environment.systemPackages =
      with pkgs;
      [ ]
      ++ optionals (sys.qemu.enable) [
        # qemu-anti-detection
        virt-manager
        virt-viewer
        spice
        spice-gtk
        spice-protocol
        virtio-win
        win-spice
        adwaita-icon-theme
      ];

    services.spice-vdagentd.enable = true;
    # services.qemuGuest.enable = true;
    virtualisation = mkIf (sys.qemu.enable) {
      docker = {
        enable = true;
        # Set up resource limits
        daemon.settings = {
          experimental = true;
          default-address-pools = [
            {
              base = "172.30.0.0/16";
              size = 24;
            }
          ];
        };
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };
      kvmgt.enable = true;
      spiceUSBRedirection.enable = true;
      libvirtd = {
        enable = true;
        qemu = {
          package = qemu-anti-detection;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
          swtpm.enable = true;
        };
      };

      lxd.enable = false;
    };
  };
}
