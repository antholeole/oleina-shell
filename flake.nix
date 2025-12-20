{
  description = "Anthony's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-root.url = "github:srid/flake-root";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixzx = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:antholeole/nixzx";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    nixzx,
    quickshell,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      perSystem = {
        system,
        pkgs,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            nixzx.overlays.default
          ];

          config.allowUnfree = true;
        };
      };

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      imports = [
        inputs.flake-root.flakeModule
        inputs.flake-parts.flakeModules.flakeModules

        ./devshell.nix
      ];
    };
}
