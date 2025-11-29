{ flake-inputs, pkgs, lib, ...}:

{
  imports = [
    flake-inputs.plasma-manager.homeModules.plasma-manager
    flake-inputs.fakwin.homeManagerModules.default
  ];

  systemd.user.services.i3-in-plasma = {
    Install.WantedBy = [ "plasma-workspace.target" ];
    Unit.Before = [ "plasma-workspace.target" ];
    Service = {
      ExecStart = pkgs.lib.getExe' pkgs.i3 "i3";
      Restart = "on-failure";
      Slice = "session.slice";
    };
  };
  systemd.user.services.plasma-kwin_x11 = {
    Unit.WantedBy = lib.mkForce [ ];
    Service.ExecStart = pkgs.lib.getExe' pkgs.coreutils "true";
  };

  services.fakwin.enable = true;

  xsession.windowManager.i3 = {
    config.window.commands = [
      {
        criteria.title = "^Bureau @ QRect.*$";
        command = "kill";
      }
      {
        criteria.class = "plasmashell";
        command = "floating enable, border none";
      }
      {
        criteria.class = "Plasmoidviewer";
        command = "floating enable, border none";
      }
    ];

    extraConfig = ''
      no_focus [class="plasmashell" window_type="notification"]
    '';
  };

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    workspace.colorScheme = "BreezeDark";
    workspace.theme = "default";

    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    panels = [{
      alignment = "center";
      location = "top";
      widgets = [
        "org.kde.plasma.kickoff"
        "org.kde.plasma.clipboard"
        "org.kde.plasma.bluetooth"
        "org.kde.plasma.notifications"
        "org.kde.plasma.panelspacer"
        "org.kde.plasma.mediacontroller"
        "org.kde.plasma.panelspacer"
        "org.kde.plasma.systemtray"
        "org.kde.plasma.digitalclock"
      ];
    }];

    # Note: does not seem to work, prob due to replacing KWin.
    # I have to enable gammastep separately
    kwin.nightLight = {
      enable = true;
      mode = "times";
      time.evening = "22:00";
      time.morning = "08:00";
      transitionTime = 120;
    };
  };


  services.kdeconnect.enable = true;
  services.kdeconnect.indicator = true;
}
