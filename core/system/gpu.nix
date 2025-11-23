{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  device = config.modules.device;
  env = config.modules.usrEnv;
in
{
  config = mkIf (device.gpu == "nvidia" || device.gpu == "hybrid-nv") {
    # nvidia drivers are unfree software
    nixpkgs.config.allowUnfree = true;

    services.xserver = mkMerge [
      {
        videoDrivers = [ "nvidia" ];
      }
    ];

    boot = {
      # blacklist nouveau module so that it does not conflict with nvidia drm stuff
      # also the nouveau performance is godawful, I'd rather run linux on a piece of paper than use nouveau
      kernelModules = [ "nvidia-uvm" ];
      blacklistedKernelModules = [ "nouveau" ];
    };

    environment = {
      sessionVariables = mkMerge [
        { LIBVA_DRIVER_NAME = "nvidia"; }

        (mkIf (env.isWayland) {
          WLR_NO_HARDWARE_CURSORS = "1";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          MESA_DISK_CACHE_SINGLE_FILE = "1";
          __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
          DXVK_STATE_CACHE = "1";
          MOZ_DISABLE_RDD_SANDBOX = "1";
          NVD_BACKEND = "direct";
          # GBM_BACKEND = "nvidia-drm"; # breaks firefox apparently
          VDPAU_DRIVER = "va_gl";
        })
      ];
      systemPackages = with pkgs; [
        mesa-demos
        libva
        libva-utils
        xorg.libxcb
        cudaPackages.cudatoolkit
      ];
    };
    boot.kernelParams = [ "nvidia-drm.fbdev=1" ];
    hardware = {
      nvidia = {
        package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
        # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        #   version = "565.57.01";
        #   sha256_64bit = "sha256-buvpTlheOF6IBPWnQVLfQUiHv4GcwhvZW3Ks0PsYLHo=";
        #   sha256_aarch64 =
        #     "sha256-aDVc3sNTG4O3y+vKW87mw+i9AqXCY29GVqEIUlsvYfE=";
        #   openSha256 = "sha256-/tM3n9huz1MTE6KKtTCBglBMBGGL/GOHi5ZSUag4zXA=";
        #   settingsSha256 =
        #     "sha256-H7uEe34LdmUFcMcS6bz7sbpYhg9zPCb/5AmZZFTx1QA=";
        #   persistencedSha256 =
        #     "sha256-hdszsACWNqkCh8G4VBNitDT85gk9gJe1BlQ8LdrYIkg=";
        #   # patches = [ rcu_patch ];
        # };
        modesetting.enable = mkDefault true;

        open = true;
        nvidiaSettings = false;
      };

      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
          libvdpau-va-gl
        ];
        extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
      };
    };
  };
}
