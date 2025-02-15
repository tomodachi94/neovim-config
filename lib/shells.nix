{ pkgs, home-manager, disko, checks, ... }:
let
  treefmt-deps = with pkgs; [
    treefmt
    taplo
    stylua
    statix
    deadnix
    yamlfmt
    nixpkgs-fmt
    python3Packages.mdformat
    python3Packages.mdformat-gfm
    python3Packages.mdformat-frontmatter
    python3Packages.mdformat-footnote
  ];
in
{

  default = pkgs.mkShellNoCC {
    packages = with pkgs; [
      nixos-rebuild
      just
      selene
      jq
      home-manager.packages.${system}.default
    ] ++ (lib.optional stdenv.hostPlatform.isLinux [ disko.packages.${system}.disko ])
    ++ treefmt-deps;
    inherit (checks.${pkgs.system}.pre-commit-check) shellHook;
  };
  ci = pkgs.mkShellNoCC {
    packages = with pkgs; [
      just
      nixos-rebuild
      jq
      selene
    ] ++ treefmt-deps;
  };
}
