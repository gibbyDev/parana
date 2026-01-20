{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    package = pkgs.vscode;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        github.copitlot
        vscodevim.vim
        esbenp.prettier-vscode
        ms-azuretools.vscode-docker
      ];


    };
  };
}
