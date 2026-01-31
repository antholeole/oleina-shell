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

      flake = {
        homeModules.oleina-shell = {
          config,
          pkgs,
          lib,
          ...
        }:
          with lib; let
            cfg = config.services.oleina-shell;
          in {
            options.services.oleina-shell = {
              enable = mkEnableOption "Enable the custom oleina-shell environment";
            };

            config = let
              defaultConfig = "default";
            in
              mkIf cfg.enable {
                package = pkgs.symlinkJoin {
                  name = "quickshell";
                  paths = [
                    # TODO: should be valid for hyprland as well, for the tablet.
                    config.programs.niri.package

                    pkgs.quickshell
                  ];
                };

                enable = true;
                activeConfig = defaultConfig;
                systemd.enable = true;
                configs = {
                  ${defaultConfig} = "${self}/confs/quickshell";
                };
              
              };
          };
      };
    };
}
