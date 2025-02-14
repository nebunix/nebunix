{
  inputs = { };

  outputs =
    { ... }:
    {
      templates = {
        starter-minimal = {
          path = ./templates/starter-minimal;
          description = "A minimal NixOS configuration using nebunix";
        };
      };
    };
}
