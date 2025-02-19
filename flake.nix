{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    programsdb = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }:
    {
      utils = {
        mkConfiguration =
          {
            systemInformation,
            nebunixModules,
            configPath,
            specialArgs ? { },
          }:
          {
            "${systemInformation.hostName}" = nixpkgs.lib.nixosSystem {
              inherit (systemInformation) system;

              specialArgs = {
                inherit systemInformation;
              } // specialArgs;

              modules = [
                (
                  { ... }:
                  {
                    nixpkgs.overlays = [
                      (final: prev: { unstable = nixpkgs-unstable.legacyPackages.${systemInformation.system}; })
                    ];
                  }
                )

                (configPath + "/hosts/${systemInformation.hostName}/configuration.nix")
                (configPath + "/hosts/${systemInformation.hostName}/hardware-configuration.nix")

                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.backupFileExtension = "backup";
                  home-manager.extraSpecialArgs = {
                    inherit systemInformation;
                  } // specialArgs;
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

        starter-basic = {
          path = ./templates/starter-basic;
          description = "A basic NixOS configuration using nebunix with a window manager, browser and terminal";
        };

        nebunix-module = {
          path = ./templates/nebunix-module;
          description = "Base template for creating new nebunix modules";
        };
      };
    };
}
