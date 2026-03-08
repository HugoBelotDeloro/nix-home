{ ... }:

let
  colourScheme = import ./colour-scheme.nix;
in
{
  programs.i3status-rust.enable = true;
  programs.i3status-rust.bars.default = {
    icons = "awesome6";
    theme = "native";
    settings.theme.overrides = with colourScheme.bottomBar; {
      idle_bg = background;
      idle_fg = text;
      info_bg = background;
      info_fg = text;
      good_bg = background;
      good_fg = text;
      warning_bg = warning;
      warning_fg = background;
      critical_bg = critical;
      critical_fg = background;
      separator_bg = background;
      separator_fg = text;
      separator = "native";
      # end_separator = ""; # Creates an empty "block" at the end, forcing a draw of the native separator.
    };
    blocks =
      let
        disk_defaults = {
          block = "disk_space";
          info_type = "used";
          alert = 90;
          warning = 80;
        };
        as_gb = "eng(hide_unit:true, hide_prefix:true, prefix:G)";
        pc = "eng(w:2)";
      in
      [
        {
          block = "bluetooth";
          mac = "AC:80:0A:CA:EE:E4";
        }
        {
          block = "battery";
        }
        {
          block = "amd_gpu";
          format_alt = " $icon $vram_used.${as_gb}/$vram_total ";
          error_format = "";
        }
        {
          block = "cpu";
        }
        (
          disk_defaults
          // {
            path = "/";
            format = " $icon root: $percentage.${pc} ";
            format_alt = " $icon root: $used.${as_gb}/$total ";
            merge_with_next = true;
          }
        )
        (
          disk_defaults
          // {
            path = "/nix";
            format = "nix: $percentage.${pc} ";
            format_alt = "nix: $used.${as_gb}/$total ";
          }
        )
        {
          block = "memory";
          format = " $icon $mem_total_used_percents.${pc} ";
          format_alt = " $icon $mem_total_used.${as_gb}/$mem_total ";
        }
        {
          block = "time";
          format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          interval = 5;
        }
      ];
  };
}
