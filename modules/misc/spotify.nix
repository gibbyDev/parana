{ pkgs, ... }:

{
  home.packages = [
    pkgs.spotify
  ];

  # Prevent Spotify from launching on startup by removing its autostart entry
#  xdg.configFile."autostart/spotify.desktop".force = false;
}

