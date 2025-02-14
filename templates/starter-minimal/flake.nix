{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nebunix.url = "github:nebunix/nebunix";
    nebunix-base.url = "github:nebunix/base";
  };

  outputs =
    { home-manager, nebunix, nixpkgs, ... }@inputs:
    {
      nixosConfigurations =
        nebunix.utils.mkConfiguration {
          hostName = "nebunix";
          system = "x86_64-linux";
          userName = "john";
          fullName = "John Doe";
        };
    };
}
