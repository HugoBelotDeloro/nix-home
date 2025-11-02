{ flake-inputs, pkgs, ... }:

let
  sddm-astronaut-custom = pkgs.sddm-astronaut.override {
      embeddedTheme = "black_hole";
      themeConfig = {
        FormPosition = "left";
        PartialBlur = "true";
        ScreenPadding = "0";
        Background = "${flake-inputs.self.resources}/wallpapers/Citlali.png";
      };
  };
in {
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    extraPackages = [ sddm-astronaut-custom ];
  };

  environment.systemPackages = [ sddm-astronaut-custom ];
}
