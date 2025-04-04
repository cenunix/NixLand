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
    networkmanagerapplet
  ];
  networking = {
    # dns
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
      # if your minecraft server is not worky
      # this is probably why
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
    wireguard.interfaces = {
      # "wg0" is the network interface name. You can name the interface arbitrarily.
      wg0 = {
        # Determines the IP address and subnet of the client's end of the tunnel interface.
        ips = [
          "10.177.100.76/32"
          "fd7d:76ee:e68f:a993:c1c9:1e68:ee1e:d818/128"
        ];
        listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

        # Path to the private key file.
        #
        # Note: The private key can also be included inline via the privateKey option,
        # but this makes the private key world-readable; thus, using privateKeyFile is
        # recommended.
        privateKeyFile = "/home/cenunix/Downloads/privatekey.key";

        peers = [
          # For a client configuration, one peer entry for the server will suffice.

          {
            # Public key of the server (not a file path).
            publicKey = "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk=";

            # Forward all the traffic via VPN.
            allowedIPs = [ "0.0.0.0/0" ];
            # Or forward only particular subnets
            #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

            endpoint = "america3.vpn.airdns.org:1637"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

            persistentKeepalive = 15;
          }
        ];
      };
    };
  };
  # services.resolved = {
  #   enable = true;
  #   dnssec = "true";
  #   domains = [ "~." ];
  #   fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  #   dnsovertls = "true";
  # };
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
