{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs =
    { nixpkgs, ... }:
    {
      utils = {
        mkConfiguration =
          {
            systemInformation,
            modules,
          }:
          {
            "${systemInformation.hostName}" = nixpkgs.lib.nixosSystem {
              inherit (systemInformation) system;

              specialArgs = {
                inherit systemInformation;
              };

              modules = [
                builtins.toPath "./hosts/${systemInformation.hostName}/configuration.nix"
                builtins.toPath "./hosts/${systemInformation.hostName}/hardware-configuration.nix"
              ] ++ modules;
            };
          };
      };
    
      templates = {
        starter-minimal = {
          path = ./templates/starter-minimal;
          description = "A minimal NixOS configuration using nebunix";
        };
      };
    };
}
