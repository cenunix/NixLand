{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  sys = config.modules.system.virtualization;
in
{
  config = mkIf (sys.enable) {
    environment.systemPackages =
      with pkgs;
      [ ]
      ++ optionals (sys.qemu.enable) [
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
          package = pkgs.qemu_kvm;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
          swtpm.enable = true;
        };
      };

      lxd.enable = false;
    };
  };
}
