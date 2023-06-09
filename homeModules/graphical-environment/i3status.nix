{ config, lib, pkgs, ... }:

{
  programs.i3status = {
    enable = true;
    enableDefault = false;

    general = {
      colors = true;
      interval = 5;
      color_good = "#2AA198";
      color_bad = "#586E75";
      color_degraded = "#DC322F";
    };

    modules = {
      cpu_usage = {
        position = 1;
        settings = {
          format = " cpu %usage ";
        };
      };

      "disk /" = {
        position = 2;
        settings = {
          format = " ⛁ %avail ";
        };
      };

      "wireless _first_" = {
        position = 3;
      };

      "ethernet _first_" = {
        position = 4;
        settings = {
          format_up = " lan: %ip %speed ";
          format_down = " no lan ";
        };
      };

      "battery all" = {
        position = 5;
        settings = {
          format = " %status  %percentage ";
          format_down = "No battery";
          last_full_capacity = true;
          integer_battery_capacity = true;
          status_chr = "⚡";
          status_bat = "";
          status_unk = "";
          status_full = "☻";
          low_threshold = 15;
          threshold_type = "time";
        };
      };

      memory = {
        position = 6;
        settings = {
          format = " %used | %total";
          threshold_degraded = "1G";
          format_degraded = "MEMORY < %available";
        };
      };

      "tztime local" = {
        position = 7;
        settings = {
          format = " %d.%m. %H:%M";
        };
      };
    };
  };
}
