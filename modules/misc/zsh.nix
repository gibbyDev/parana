{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      # Powerlevel10k Theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      # zsh-autosuggestions
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

      # Ensure fpath includes syntax-highlighting
      fpath=(${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting $fpath)

      # zsh-syntax-highlighting (must be last)
      if [[ -f ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      else
        echo "zsh-syntax-highlighting not found!"
      fi
    '';


    shellAliases = {
      ll = "ls -la";
      hmr = "home-manager switch --flake .";
      reload = "exec zsh";
    };
  };

  # Fonts for Powerlevel10k icons and general nerd fonts
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono

    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
}

