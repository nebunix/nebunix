{ ... }:

{
  nebunix = {
    user = {
      fullName = "John Doe";
    };

    localization = {
      consoleKeyMap = "us";
      timeZone = "UTC";
      locale = "en_US.UTF-8";

      xkb.layout = "us";
    };

    defaultPrograms = {
      terminal = "kitty";
      browser = "firefox";
      shell = "fish";
    };

    wallpaper.path = ../../assets/wallpapers/nebula.jpg;

    fonts.monospaceFont = "JetBrains Mono Nerd Font Mono";
  };
}
