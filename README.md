# nebunix

A set of pre-configured NixOS modules that fit nicely together.

> [!IMPORTANT]
> `nebunix` is in very early development. As of now, it is only a very
> minimal system comparable to a new install of NixOS without
> any desktop environments.

## Getting Started

1. Initialise a new flake using the nebunix template:

```bash
$ nix flake new --template github:nebunix/nebunix#starter-minimal ~/.nixos
$ cd ~/.nixos
```

2. Generate your hardware configuration into `hosts/nebunix/` using the following command:

```bash
$ nixos-generate-config --dir hosts/nebunix
```

3. Set your desired user name by editing the `userName` variable in `flake.nix`.

4. Edit the options in `hosts/nebunix/configuration.nix`. You'll at least want to
change the `localization.consoleKeyMap` and `user.fullName` values.

5. Set your desired host name by editing the `hostName` variable in `flake.nix`.
The host name will be the name of your configuration. A common approach is to
use the name of your device (for example "surface-laptop-go").

6. `nebunix` expects your configuration to be in `hosts/<host name>/`. If you
changed the host name in `flake.nix`, you will have to rename `hosts/nebunix`
accordingly:

```bash
$ mv hosts/nebunix hosts/<host name>
```

7. Apply the configuration:

```bash
$ sudo nixos-rebuild switch --flake .#<host name>
```

After running this command for the first time, you can omit the host name in any
future rebuilds:

```bash
$ sudo nixos-rebuild switch --flake .
```
