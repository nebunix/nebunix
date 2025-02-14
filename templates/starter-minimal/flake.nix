{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { home-manager, nixpkgs, ... }:
    {
      nixosConfigurations =
        let
          mkConfiguration =
            { name, system }:
            {
              "${name}" = nixpkgs.lib.nixosSystem {
                inherit system;

                modules = [
                  (./hosts + "/${name}/configuration.nix")
                  (./hosts + "/${name}/hardware-configuration.nix")
                ];
              };
            };
        in
        mkConfiguration {
          name = "nebunix";
          system = "x86_64-linux";
        };
    };
}
