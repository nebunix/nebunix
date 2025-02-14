{
  inputs = {
    nebunix.url = "github:nebunix/nebunix";
    nebunix-base.url = "github:nebunix/base";
  };

  outputs =
    { home-manager, nebunix, ... }@inputs:
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
