{ config, ... }:
{
  programs.ncmpcpp = {
    enable = true;
  };
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
  };

  programs.beets = {
    enable = true;
    mpdIntegration.enableStats = true;
    mpdIntegration.enableUpdate = true;
    settings = {
      directory = "~/Music";
      import.copy = false;
      plugins = [
        "fish"
        "info"
      ];
    };
  };
}
