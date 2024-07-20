{ pkgs, ... }:
let
  cp = pkgs.callPackage;
in
{
  "3ds" = cp ./all/3ds.nix { };
  awesome-lint = cp ./all/awesome-lint { };
  ultisnips-vscode = cp ./all/ultisnips-vscode.nix { };
  zsh-window-title = cp ./all/zsh-window-title.nix { };
} // pkgs.lib.optionalAttrs pkgs.stdenv.isLinux {
  crossover = cp ./linux/crossover.nix { };
} // pkgs.lib.optionalAttrs pkgs.stdenv.isDarwin {
  developercolorpicker = cp ./darwin/developercolorpicker.nix { };
}
