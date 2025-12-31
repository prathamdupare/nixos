{
  description = "Snap Install";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-snapd.url = "github:nix-community/nix-snapd";
    nix-snapd.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs
    , nix-snapd
    ,
    }: {
      nixosConfigurations.my-hostname = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nix-snapd.nixosModules.default
          {
            services.snap.enable = true;
          }
        ];
      };
    };
}
