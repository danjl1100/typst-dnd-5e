{
  description = "advent of code 2023";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
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

        typ_files = let
          typFilter = path: type: ((type == "directory") || (builtins.any (ext: pkgs.lib.hasSuffix ext path) [".typ"]));
        in
          pkgs.lib.cleanSourceWith {
            src = ./.;
            filter = typFilter;
          };
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
          default = pkgs.runCommand "all" {} ''
            # print commands, and use globstar
            set -x
            shopt -s globstar

            cp -r "${typ_files}" src/
            pushd src >/dev/null

            src_files=(**/*.typ)
            for f in "''${src_files[@]}" ; do
              dest="$out/''${f%.typ}.pdf"
              mkdir -p "$(dirname "$dest")"
              "${pkgs.typst}/bin/typst" compile "$f" "$out/''${f%.typ}.pdf"
            done

            # revert settings
            set +x
            shopt -u globstar
          '';
        };

        apps = {
        };

        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.alejandra
            pkgs.typst
            pkgs.typstfmt
          ];
        };
      }
    );
}
