# /etc/nixos/modules/nixvim.nix
{ config
, pkgs
, ...
}: {
  imports = [
    ./options.nix # Import the global options
    ./keymaps.nix
    ./plugins.nix
  ];

  programs.nixvim = {    
    enable = true;
    colorschemes.tokyonight.enable = true;
    globals.mapleader = " ";
    clipboard = {
      providers = {
        wl-copy.enable = true; # Wayland
      };
      register = "unnamedplus";
    };
  };
}
