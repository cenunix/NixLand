{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
with lib;
let
  device = config.modules.device;
in
{
  hm.home.packages =
    with pkgs;
    [ ]
    ++
      optionals
        # shared packages between all systems
        (builtins.elem device.type [
          "desktop"
          "laptop"
          "armlaptop"
        ])
        [
          #actual apps
          ttyper
          spotify-player
          wofi
          wpa_supplicant_gui
          obsidian
          zathura
          gsettings-desktop-schemas
          calibre
          hyprpicker
          gnome-podcasts
          grimblast
          # libreoffice-fresh
          libnotify
          jellyfin-media-player
          thunderbird
          telegram-desktop
          bitwarden-desktop

          #media apps
          mpv
          playerctl
          pavucontrol
          pulsemixer
          pulseaudio
          imv
          virtiofsd

          # command line tools I use frequently
          neofetch
          nnn # terminal file manager

          # archives
          zip
          xz
          unzip
          p7zip

          # utils
          ripgrep # recursively searches directories for a regex pattern
          jq # A lightweight and flexible command-line JSON processor
          yq-go # yaml processor https://github.com/mikefarah/yq
          eza # A modern replacement for ‘ls’
          fzf # A command-line fuzzy finder
          killall

          # networking tools
          mtr # A network diagnostic tool
          iperf3
          dnsutils # `dig` + `nslookup`
          ldns # replacement of `dig`, it provide the command `drill`
          aria2 # A lightweight multi-protocol & multi-source command-line download utility
          socat # replacement of openbsd-netcat
          nmap # A utility for network discovery and security auditing
          ipcalc # it is a calculator for the IPv4/v6 addresses

          # misc
          cowsay
          file
          which
          tree
          gnused
          gnutar
          gawk
          zstd
          gnupg

          # nix related
          #
          # it provides the command `nom` works just like `nix`
          # with more details log output
          nix-output-monitor

          # productivity
          hugo # static site generator
          glow # markdown previewer in terminal

          iotop # io monitoring
          iftop # network monitoring

          # system call monitoring
          strace # system call monitoring
          ltrace # library call monitoring
          lsof # list open files

          # system tools
          sysstat
          lm_sensors # for `sensors` command
          ethtool
          pciutils # lspci
          usbutils # lsusb
        ]
    ++ optionals (builtins.elem device.type [ "desktop" ]) [
    ]
    ++ optionals (builtins.elem device.type [
      "desktop"
      "laptop"
    ]) [ ]
    ++ optionals (builtins.elem device.type [ "armlaptop" ]) [
      # additional packages for arm laptop (x13s as of now) machines that use home-manager
    ];
}
