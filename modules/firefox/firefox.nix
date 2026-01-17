{ config, pkgs, lib, ...}:

{
  programs.firefox = {
    enable = true;

    # set default settings
    profiles.default = {
      isDefault = true;
      settings = {
        #"browser.startup.homepage" = "https://www.mozilla.org";
        "privacy.donottrackheader.enabled" = true;
        "network.trr.mode" = 2; # Use DNS over HTTPS
      };
    };
  };
}


