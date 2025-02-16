{
  inputs = {
    nebunix.url = "github:nebunix/nebunix";
    nebunix-base.url = "github:nebunix/base";
  };

  outputs =
    { nebunix, ... }@inputs:
    {
      nixosConfigurations = nebunix.utils.mkConfiguration {
        systemInformation = {
          hostName = "nebunix";
          system = "x86_64-linux";
          userName = "john";
        };
        nebunixModules = with inputs; [ nebunix-base ];
        configPath = ./.;
      };
    };
}
