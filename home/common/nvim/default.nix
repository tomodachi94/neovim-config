{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in
{
  imports = [ ./nix ];
  home.sessionVariables = {
    EDITOR = "${pkgs.lib.getExe pkgs.neovim}";
    VISUAL = "${pkgs.lib.getExe pkgs.neovim}";
  };
  xdg.configFile."nvim/spell".source = ./spell;
  xdg.configFile."nvim/vimscript".source = ./vimscript;
  xdg.configFile."nvim/lazy-lock.json".source = mkOutOfStoreSymlink "${dotfilesDir}/home/common/nvim/lazy-lock.json";

  xdg.configFile."nvim/lua/tomodachi94".source = ./lua/tomodachi94;
  xdg.configFile."nvim/lua/keyring".source = ./lua/keyring;

  xdg.configFile."nvim/init.lua".text = ''
    require("tomodachi94")
  '';
  xdg.configFile."nvim/lua/generated_vars.lua".text = ''
    local vars = {}
    vars.python3 = "${pkgs.python310.interpreter}"
    vars.snippet_dir = "${./lua/tomodachi94/luasnip}"
    return vars
  '';

  xdg.dataFile."nvim/lazy/lazy.nvim/doc".source = "${pkgs.vimPlugins.lazy-nvim}/doc";
  xdg.dataFile."nvim/lazy/lazy.nvim/lua".source = "${pkgs.vimPlugins.lazy-nvim}/lua";
}
