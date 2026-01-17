{ config, lib, pkgs, ... }:

let
  vaultPath = "${config.home.homeDirectory}/Documents/Notebook"; # Change if needed
  gitRepo = "git@github.com:gibbyDev/Notebook.git"; # Change this
in
{
  home.packages = with pkgs; [ obsidian ];

  home.file.".config/obsidian" = {
    source = config.lib.file.mkOutOfStoreSymlink "${vaultPath}";
  };

#  systemd.user.services.obsidian-git-sync = {
#    Unit = {
#      Description = "Auto-commit and push Obsidian Vault";
#      After = [ "network-online.target" ];
#    };

#    Service = {
#      ExecStart = pkgs.writeShellScript "obsidian-git-sync" ''
#        cd ${vaultPath}
#        if [ -n "$(git status --porcelain)" ]; then
#          git add .
#          git commit -m "Auto-sync: $(date)"
#          git push origin main
#        fi
#      '';
#      Restart = "always";
#    };

#    Install = { WantedBy = [ "default.target" ]; };
#  };
}

