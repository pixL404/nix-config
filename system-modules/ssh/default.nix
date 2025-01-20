{ config, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    # only start systemd service on incoming connection
    startWhenNeeded = true;

    # TODO: disable once I have secret management with nix figured out
    settings.PasswordAuthentication = true;
  };
  # restrict ssh source IP with extracommands
  networking.firewall.extraCommands = ''
    iptables -A nixos-fw -p tcp --source 192.168.0.0/24 --dport 22:22 -j nixos-fw-accept
  '';
}
