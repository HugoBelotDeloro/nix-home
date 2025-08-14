{ ... }:

{
  services.openssh = {
    enable = true;
    banner = "Authorized access only!\nIf you are not authorized to access or use this system, disconnect now!\n";
    allowSFTP = false;
    settings = {
      PasswordAuthentication = false;
      X11Forwarding = false;
      KbdInteractiveAuthentication = false;
    };
    extraConfig = ''
      AllowTcpForwarding yes
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
  };
}
