{ config, pkgs, lib, ... }:

{
  ########################################
  # Plasma 6
  ########################################

  programs.plasma = {
    enable = true;

    ####################################
    # Workspace & Appearance
    ####################################

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      iconTheme   = "breeze-dark";
      cursorTheme = "breeze_cursors";
      theme       = "BreezeDark";
    };

    ####################################
    # KWin (Window Manager)
    ####################################

    kwin.effects = {
      blur.enable          = true;
      translucency.enable  = true;
      desktopGrid.enable   = true;
      overview.enable      = true;
    };

    ####################################
    # Panels / Taskbar
    ####################################

    panels = [
      {
        location = "bottom";
        height   = 44;

        widgets = [
          # Application launcher
          {
            name = "org.kde.plasma.kickoff";
            config.General.icon = "nix-snowflake";
          }

          # Task manager
          {
            name = "org.kde.plasma.icontasks";
            config.General = {
              launchers = [
                "applications:org.kde.konsole.desktop"
                "applications:firefox.desktop"
                "applications:org.kde.dolphin.desktop"
              ];
              groupTasks        = true;
              separateLaunchers = false;
            };
          }

          # System tray
          { name = "org.kde.plasma.systemtray"; }

          # Clock
          {
            name = "org.kde.plasma.digitalclock";
            config.Appearance.showSeconds = false;
          }
        ];
      }
    ];

    ####################################
    # Shortcuts / Keybinds
    ####################################

    shortcuts = {
      "Wallpaper Next" = {
        command = "${config.home.homeDirectory}/.local/bin/set-wallpaper.sh next";
        key     = "Meta+]";
      };

      "Wallpaper Prev" = {
        command = "${config.home.homeDirectory}/.local/bin/set-wallpaper.sh prev";
        key     = "Meta+[";
      };

      "KWin Overview" = {
        command = "qdbus org.kde.KWin /KWin toggleOverview";
        key     = "Meta+W";
      };
    };
  };

  ########################################
  # Packages needed by Plasma
  ########################################

  home.packages = with pkgs; [
    qttools        # qdbus
    breeze-icons
  ];

  ########################################
  # Environment (Wayland-safe defaults)
  ########################################

  home.sessionVariables = {
    QT_QPA_PLATFORM     = "wayland";
    XDG_CURRENT_DESKTOP = "KDE";
  };
}

