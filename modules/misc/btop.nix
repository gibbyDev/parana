{ config, pkgs, ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox-dark"; # You can change this to any other theme
      theme_background = false;
      vim_keys = true;
      # You can add more settings from: https://github.com/aristocratos/btop#configuration
    };
  };
}

