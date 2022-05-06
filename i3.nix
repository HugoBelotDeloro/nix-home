{ config, lib, pkgs, ... }:

{
  xsession.windowManager.i3 =
  let
    mod = "Mod4";
    mode_system = "(l)ock, (e)xit, switch_(u)ser, (s)uspend, (h)ibernate, (r)eboot, (Shift+s)hutdown";
    i3lock = "${pkgs.i3lock}/bin/i3lock -c 000000";
  in {
    enable = true;

    config = {
      modifier = mod;

      defaultWorkspace = "workspace 1";
      workspaceAutoBackAndForth = true;

      startup = [
        { command = "${pkgs.networkmanagerapplet}/bin/nm-applet"; notification = false; }
        { command = "${pkgs.pasystray}/bin/pasystray --volume-max=100 --volume-inc=1 --notify=all"; notification = false; }
      ];

      gaps = {
        inner = 14;
        outer = -2;
        smartBorders = "on";
        smartGaps = true;
      };

      keybindings = let
        pamixer = command: "${pkgs.pamixer}/bin/pamixer ${command}";
      in lib.mkOptionDefault {
        "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${mod}+Shift+q" = "kill";
        "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show run";
        "${mod}+q" = "split toggle";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+e" =  ''exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"'';
        "${mod}+9" = "exec --no-startup-id ${i3lock}";
        "${mod}+0" = ''mode "${mode_system}"'';

        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pamixer "--increase 5"}";
        "Shift+XF86AudioRaiseVolume" = "exec --no-startup-id ${pamixer "--increase 1"}";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pamixer "--decrease 5"}";
        "Shift+XF86AudioLowerVolume" = "exec --no-startup-id ${pamixer "--decrease 1"}";
        "XF86AudioMute" = "exec --no-startup-id ${pamixer "--toggle-mute"}";

        "${mod}+Ctrl+Right" = "workspace next";
        "${mod}+Ctrl+Left" = "workspace prev";

        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+m" = "focus right";

        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+m" = "move right";

        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

       "${mod}+1" = "workspace 1";
       "${mod}+2" = "workspace 2";
       "${mod}+3" = "workspace 3";
       "${mod}+4" = "workspace 4";
       "${mod}+5" = "workspace 5";
       "${mod}+6" = "workspace 6";
       "${mod}+7" = "workspace 7";
       "${mod}+8" = "workspace 8";
      
       "${mod}+Ctrl+1" = "move container to workspace 1";
       "${mod}+Ctrl+2" = "move container to workspace 2";
       "${mod}+Ctrl+3" = "move container to workspace 3";
       "${mod}+Ctrl+4" = "move container to workspace 4";
       "${mod}+Ctrl+5" = "move container to workspace 5";
       "${mod}+Ctrl+6" = "move container to workspace 6";
       "${mod}+Ctrl+7" = "move container to workspace 7";
       "${mod}+Ctrl+8" = "move container to workspace 8";
      
       "${mod}+Shift+1" = "move container to workspace 1; workspace 1";
       "${mod}+Shift+2" = "move container to workspace 2; workspace 2";
       "${mod}+Shift+3" = "move container to workspace 3; workspace 3";
       "${mod}+Shift+4" = "move container to workspace 4; workspace 4";
       "${mod}+Shift+5" = "move container to workspace 5; workspace 5";
       "${mod}+Shift+6" = "move container to workspace 6; workspace 6";
       "${mod}+Shift+7" = "move container to workspace 7; workspace 7";
       "${mod}+Shift+8" = "move container to workspace 8; workspace 8";
      };

      modes = let
        systemctl = "${pkgs.systemd}/bin/systemctl";
      in lib.mkOptionDefault {

        ${mode_system} = {
          l = "exec --no-startup-id ${i3lock}, mode default";
          s = "exec --no-startup-id ${i3lock}; exec --no-startup-id ${systemctl} suspend, mode default";
          h = "exec --no-startup-id ${i3lock}; exec --no-startup-id ${systemctl} hibernate, mode default";
          u = "exec --no-startup-id ${pkgs.lightdm}/bin/dm-tool switch-to-greeter, mode default";
          e = "exec --no-startup-id i3-msg exit, mode default";
          r = "exec --no-startup-id ${systemctl} reboot, mode default";
          "Shift+s" = "exec --no-startup-id ${systemctl} poweroff, mode default";

          Return = "mode default";
          Escape = "mode default";
        };
      };

      colors = {
        background = "#2B2C2B";

        focused = {
           border = "#556064";
           background = "#556064";
           text = "#80FFF9";
           indicator = "#FDF6E3";
           childBorder = "";
        };

        focusedInactive = {
           border = "#2F3D44";
           background = "#2F3D44";
           text = "#1ABC9C";
           indicator = "#454948";
           childBorder = "";
        };

        unfocused = {
           border = "#2F3D44";
           background = "#2F3D44";
           text = "#1ABC9C";
           indicator = "#454948";
           childBorder = "";
        };

        urgent = {
           border = "#CB4B16";
           background = "#FDF6E3";
           text = "#1ABC9C";
           indicator = "#268BD2";
           childBorder = "";
        };

        placeholder = {
           border = "#000000";
           background = "#0c0c0c";
           text = "#ffffff";
           indicator = "#000000";
           childBorder = "";
        };

      };

      bars = [
        {
          command = "${pkgs.i3-gaps}/bin/i3bar";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          position = "bottom";

          fonts = {
            names = [ "JetBrains Mono" ];
            size = 11.0;
          };

          colors = {
            activeWorkspace = {
              border = "#595B5B";
              background = "#353836";
              text = "#FDF6E3";
            };

            bindingMode = {
              border = "#16A085";
              background = "#2C2C2C";
              text = "#F9FAF9";
            };

            focusedWorkspace = {
              border = "#F9FAF9";
              background = "#16A085";
              text = "#29F34";
            };

            inactiveWorkspace = {
              border = "#595B5B";
              background = "#222D31";
              text = "#EEE8D5";
            };

            urgentWorkspace = {
              border = "#16A085";
              background = "#FDF6E3";
              text = "#E5201D";
            };

            background = "#222D31";
            separator = "#454947";
            statusline = "#F9FAF9";
            # focusedBackground = "";
            # focusedSeparator = "";
            # focusedStatusline = "";
          };
        }
      ];

    };

    extraConfig = ''
    default_border pixel 1
    default_floating_border normal

    hide_edge_borders none
    '';
  };

}
