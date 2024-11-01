{ ... }:

{
  home.sessionVariables.BROWSER = "firefox";

  programs.firefox = {
    enable = true;

    policies = let
      lock-true = {
        Value = true;
        Status = "locked";
      };
      lock-false = {
        Value = false;
        Status = "locked";
      };
    in {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DontCheckDefaultBrowser = true;
      DisplayMenuBar = "never";
      SearchBar = "unified";
      PictureInPicture = lock-false;
      OfferToSaveLogins = false;

      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Privacy Badger
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        # Cookie AutoDelete
        "CookieAutoDelete@kennydo.com" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/cookie-autodelete/latest.xpi";
          installation_mode = "force_installed";
        };
        # Decentraleyes
        "jid1-BoFifL9Vbdl2zQ@jetpack" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi";
          installation_mode = "force_installed";
        };
        # KeePassXC-Browser
        "keepassxc-browser@keepassxc.org" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "force_installed";
        };
        # Unhook
        "myallychou@gmail.com" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/youtube-recommended-videos/latest.xpi";
          installation_mode = "force_installed";
        };
        # YouTube AZERTY shortcuts fixer
        "{9fd797b0-2d26-48c6-ac64-a98f5c430ef0}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/yt-azerty-shortcuts-fixer/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      Preferences = {
        "extensions.pocket.enabled" = lock-false;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" =
          lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          lock-false;
        # "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
        # "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
        # "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        "dom.private-attribution.submission.enabled" = lock-false;
      };
    };
  };
}
