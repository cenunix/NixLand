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
            (pkgs.fetchpatch {
              url = "https://raw.githubusercontent.com/zhaodice/qemu-anti-detection/main/qemu-8.2.0.patch";
              sha256 = "sha256-vwDS+hIBDfiwrekzcd71jmMssypr/cX1oP+Oah+xvzI=";
            })
          ];
          postFixup =
            (previousAttrs.postFixup or "")
            + "\n"
            + ''
              for i in $(find $out/bin -type f -executable); do
                mv $i "$i-anti-detection"
              done
            '';
          version = "8.2.0";
          pname = "qemu-anti-detection";
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
    virtualisation = mkIf (sys.qemu.enable) {
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
