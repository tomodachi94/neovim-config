{ pkgs, tomolib, ... }:
let
  firejailWrappers = tomolib.firejailWrappers { inherit pkgs; };
in
{
  home.packages = [
    pkgs.lxqt.qps
    pkgs.vscodium-fhs # GUI IDE
    firejailWrappers.librewolf # Web browser
    pkgs.zotero
  ];

  home.sessionVariables = {
    BROWSER = pkgs.lib.getExe firejailWrappers.librewolf;
  };
}
