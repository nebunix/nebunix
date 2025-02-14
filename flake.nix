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
              ] ++ (map (nebunixModule: nebunixModule.nixosModules.default));
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
