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
      utils = {
        mkConfiguration =
          {
            systemInformation,
            nebunixModules,
            configPath,
          }:
          {
            "${systemInformation.hostName}" = nixpkgs.lib.nixosSystem {
              inherit (systemInformation) system;

              specialArgs = {
                inherit systemInformation;
              };

              modules = [
                (configPath + "/hosts/${systemInformation.hostName}/configuration.nix")
                (configPath + "/hosts/${systemInformation.hostName}/hardware-configuration.nix")

                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.backupFileExtension = "backup";
                  home-manager.users."${systemInformation.userName}" =
                    { ... }:
                    {
                      imports = [

                        (configPath + "/hosts/${systemInformation.hostName}/home.nix")
                      ];
                    };
                }
              ] ++ map (nebunixModule: nebunixModule.nixosModules.default) nebunixModules;
            };
          };
      };

      templates = {
        starter-minimal = {
          path = ./templates/starter-minimal;
          description = "A minimal NixOS configuration using nebunix";
        };

        nebunix-module = {
          path = ./templates/nebunix-module;
          description = "Base template for creating new nebunix modules";
        };
      };
    };
}
