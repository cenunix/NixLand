{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];
  networking = {
    networkmanager = {
      enable = true;
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    firewall = {
      enable = true;
      checkReversePath = false;
      trustedInterfaces = [ "virbr0" ];
      allowedTCPPorts = [
        443
        80
        22
      ];
      allowedUDPPorts = [
        443
        80
        51820
      ];
      allowPing = false;
      logReversePathDrops = true;
    };
    wg-quick.interfaces = {
      wg0 = {
        autostart = false;
        address = [
          "10.177.100.76/32"
          "fd7d:76ee:e68f:a993:c1c9:1e68:ee1e:d818/128"
        ];
        dns = [
          "10.128.0.1"
          "fd7d:76ee:e68f:a993::1"
        ];
        listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)
        privateKeyFile = "/home/cenunix/Downloads/privatekey.key";

        peers = [
          {
            publicKey = "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk=";
            presharedKeyFile = "/home/cenunix/Downloads/preshared.key";
            # Forward all the traffic via VPN.
            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];
            # Or forward only particular subnets
            #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

            endpoint = "america3.vpn.airdns.org:1637"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

            persistentKeepalive = 15;
          }
        ];
      };
    };
  };

  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
  programs = {
    ssh = {
      startAgent = true;
      askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
    };
  };
  services.openssh = {
    enable = true;
    startWhenNeeded = false;
    settings = {
      PermitRootLogin = lib.mkForce "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = lib.mkDefault false;
      UseDns = false;
      X11Forwarding = false;
    };

    # the ssh port(s) should be automatically passed to the firewall's allowedTCPports
    openFirewall = true;
    ports = [ 2317 ];

    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
