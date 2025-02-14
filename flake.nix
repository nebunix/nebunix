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
            hostName,
            system,
            userName,
            fullName,
          }:
          {
            "${hostName}" = nixpkgs.lib.nixosSystem {
              inherit system;

              specialArgs = {
                systemInformation = {
                  user = {
                    inherit userName;
                    inherit fullName;
                  };
                  inherit hostName;
                };
              };

              modules = [
                (./hosts + "/${hostName}/configuration.nix")
                (./hosts + "/${hostName}/hardware-configuration.nix")

                inputs.nebunix-base.nixosModules.default
              ];
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
