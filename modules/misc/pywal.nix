{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.programs.pywal.enable {
    # Symlink pywal-generated colors to Waybar
    home.file.".config/waybar/colors.css".source =
      "${config.xdg.cacheHome}/wal/colors-waybar.css";

    # Optional: Environment variables for pywal
    home.sessionVariables = {
      PYWAL_CACHE_DIR = "${config.xdg.cacheHome}/wal";
    };
  };
}

