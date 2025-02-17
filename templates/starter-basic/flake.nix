{
  inputs = {
    nebunix.url = "github:nebunix/nebunix";
    nebunix-base.url = "github:nebunix/base";
    nebunix-firefox.url = "github:nebunix/firefox";
    nebunix-fish.url = "github:nebunix/fish";
    nebunix-helix.url = "github:nebunix/helix";
    nebunix-kitty.url = "github:nebunix/kitty";
    nebunix-ly.url = "github:nebunix/ly";
    nebunix-sway.url = "github:nebunix/sway";
    nebunix-wallpaper.url = "github:nebunix/wallpaper";
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
        nebunixModules = with inputs; [
          nebunix-base
          nebunix-firefox
          nebunix-fish
          nebunix-helix
          nebunix-kitty
          nebunix-ly
          nebunix-sway
          nebunix-wallpaper
        ];
        configPath = ./.;
      };
    };
}
