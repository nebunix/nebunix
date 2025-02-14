{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nebunix-base = {
      url = "github:nebunix/base";
    };
  };

  outputs =
    { home-manager, nixpkgs, ... }@inputs:
    {
      nixosConfigurations =
        let
          mkConfiguration =
            {
              name,
              system,
              userName,
              fullName,
            }:
            {
              "${name}" = nixpkgs.lib.nixosSystem {
                inherit system;

                specialArgs = {
                  systemInformation = {
                    user = {
                      inherit userName;
                      inherit fullName;
                    };
                  };
                };

                modules = [
                  (./hosts + "/${name}/configuration.nix")
                  (./hosts + "/${name}/hardware-configuration.nix")

                  inputs.nebunix-base.nixosModules.base
                ];
              };
            };
        in
        mkConfiguration {
          name = "nebunix";
          system = "x86_64-linux";
          userName = "john";
          fullName = "John Doe";
        };
    };
}
