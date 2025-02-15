{ systemInformation, ... }:
{
  home-manager.users."${systemInformation.userName}" = { ... }: { };
}
