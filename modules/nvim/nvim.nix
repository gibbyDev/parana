{ config, pkgs, ... }:

let
  nvimConfigDir = "${config.home.homeDirectory}/.config/nvim";
  nvimGitRepo = "https://github.com/gibbyDev/nvim.git"; # Change this
  git = "${pkgs.git}/bin/git";
in
{
  home.activation.cloneNvimConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${nvimConfigDir}/.git" ]; then
      echo "Cloning Neovim config..."
      ${git} clone --depth=1 ${nvimGitRepo} ${nvimConfigDir}
    else
      echo "Neovim config already exists, pulling latest changes..."
      ${git} -C ${nvimConfigDir} pull
    fi
  '';

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [ wl-clipboard xclip xsel ];
  };
}

