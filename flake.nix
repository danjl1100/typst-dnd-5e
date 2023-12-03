{
  description = "advent of code 2023";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    # common
    self,
    flake-utils,
    nixpkgs,
  }: let
    target_systems = ["x86_64-linux" "aarch64-darwin"];
  in
    flake-utils.lib.eachSystem target_systems (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        shellcheck = {
          src_dir,
          script_name,
        } @ inputs:
          pkgs.runCommand "shellcheck" inputs ''
            cd "$src_dir"
            ${pkgs.shellcheck}/bin/shellcheck "$script_name" -x
            touch $out
          '';
      in rec {
        checks = {
          nix-alejandra = pkgs.stdenvNoCC.mkDerivation {
            name = "nix-alejandra";
            src = pkgs.lib.cleanSourceWith {
              src = ./.;
              filter = path: type: ((type == "directory") || (pkgs.lib.hasSuffix ".nix" path));
            };
            phases = ["buildPhase"];
            nativeBuildInputs = [pkgs.alejandra];
            buildPhase = "(alejandra -qc $src || alejandra -c $src) > $out";
          };
        };

        packages = {
        };

        apps = {
        };

        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.alejandra
            pkgs.typst
          ];
        };
      }
    );
}
