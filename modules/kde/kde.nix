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
      iconTheme = "breeze-dark";
      cursorTheme = "breeze_cursors";
      theme = "BreezeDark";
    };

    ####################################
    # KWin (Window Manager)
    ####################################

    kwin = {
      effects = {
        blur.enable = true;
        translucency.enable = true;
        desktopGrid.enable = true;
        overview.enable = true;
      };

      # Krohnkite tiling script
      scripts = {
        krohnkite = {
          enable = true;
          package = pkgs.krohnkite;
        };
      };
    };

    ####################################
    # Panels / Taskbar
    ####################################

    panels = [
      {
        location = "bottom";
        height = 44;

        widgets = [
          # Application launcher
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "nix-snowflake";
              };
            };
          }

          # Task manager
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  "applications:org.kde.konsole.desktop"
                  "applications:firefox.desktop"
                  "applications:org.kde.dolphin.desktop"
                ];
                groupTasks = true;
                separateLaunchers = false;
              };
            };
          }

          # System tray
          { name = "org.kde.plasma.systemtray"; }

          # Clock
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                showSeconds = false;
              };
            };
          }
        ];
      }
    ];

    ####################################
    # Shortcuts / Keybinds
    ####################################

    shortcuts = {
      # Wallpaper cycling (your script)
      "Wallpaper Next" = {
        command = "/home/cody/.local/bin/set-wallpaper.sh next";
        key = "Meta+]";
      };

      "Wallpaper Prev" = {
        command = "/home/cody/.local/bin/set-wallpaper.sh prev";
        key = "Meta+[";
      };

      # Krohnkite / KWin bindings
      "KWin Toggle Tiling" = {
        command = "qdbus org.kde.KWin /KWin toggleTiling";
        key = "Meta+T";
      };

      "KWin Overview" = {
        command = "qdbus org.kde.KWin /KWin toggleOverview";
        key = "Meta+W";
      };
    };
  };

  ########################################
  # Packages needed by Plasma config
  ########################################

  home.packages = with pkgs; [
    krohnkite
    qttools        # qdbus
    breeze-icons
  ];

  ########################################
  # Environment (important for shortcuts)
  ########################################

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "KDE";
  };
}

