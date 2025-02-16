{ ... }:
{
  config.nebunix = {
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

    fonts.monospaceFont = "JetBrains Mono Nerd Font Mono";
  };
}
