{ config, pkgs, lib, src, ... }:

{
  imports = [
    ../../modules
  ];

  home.username = "cody";
  home.homeDirectory = "/home/cody";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    kitty
    obs-studio
    docker
    ffmpeg
    unzip
    gimp
    neofetch
    fastfetch
    tree
    git
    nodejs_20
    tailwindcss
    templ
    protobuf
    air
    pywal
    bat

    (pkgs.writeShellScriptBin "protoc-gen-go" ''
      export PATH=$HOME/.go/bin:$PATH
      go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
    '')
    (pkgs.writeShellScriptBin "protoc-gen-go-grpc" ''
      export PATH=$HOME/.go/bin:$PATH
      go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
    '')
  ];

  nixpkgs.config.allowUnfree = true;

  # Copy all scripts from ./scripts into ~/.local/share/bin
  home.activation.copyScripts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.local/share/bin
    rm -rf ~/.local/share/bin/*  # Remove old scripts
    cp -r ${../../scripts}/* ~/.local/share/bin/
    chmod +x ~/.local/share/bin/*
  '';

  home.activation.copyWallpapers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/Pictures/wallpapers
    rm -rf ~/Pictures/wallpapers/*  # Remove old scripts
    cp -r ${../../wallpapers}/* ~/Pictures/wallpapers/
  '';

  programs.home-manager.enable = true;

}


