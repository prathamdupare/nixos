#flake.nix

{
  description = "NixOS config flake";

  inputs = {
    # Nixpkgs input
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Add devenv and android-nixpkgs inputs
    # Home-Manager (THE CORRECT WAY)
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    vicinae.url = "github:vicinaehq/vicinae";
    devenv.url = "github:cachix/devenv/latest";
    android-nixpkgs.url = "github:tadfisher/android-nixpkgs/stable";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixvim input
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-snapd input
    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/hyprland?ref=v0.36.0";

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixvim
    , unstable
    , nix-snapd
    , quickshell
    , android-nixpkgs
    , home-manager
    , ...
    } @ inputs: {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          inputs.nixvim.nixosModules.nixvim
          inputs.nix-snapd.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
