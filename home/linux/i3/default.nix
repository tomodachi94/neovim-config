{ config, pkgs, lib, vars, ... }:
{
  stylix.targets.i3.enable = true;
  xdg.configFile."i3/config" = lib.mkIf config.local.eagerSetup.enableGraphicalApps {
    text = ''
      ## start manual config ##
      set $wallpaper_path "${config.stylix.image}"
      set $font "${vars.font.monospace}"
      include ${./all.config}
      include ${./background.config}
      include ${./programs.config}
      include ${./keybinds.config}
      include ${./bar.config}
      ## end manual config ##
    '';
    onChange = ''
      	  if [ ${pkgs.lib.getExe pkgs.xorg.xprop} -root | ${pkgs.lib.getExe pkgs.gnugrep} i3 ]; then
      	    noteEcho "Reloading i3 to apply changes"
      	    ${pkgs.i3}/bin/i3-msg reload
      	  else
      	    warnEcho "i3 not running, skipping reload..."
      	  fi
      	'';
  };

  # For cleanliness, this contains any packages that are exclusively used in this configuration.
  home.packages = lib.optionals (config.local.system.linux && config.local.eagerSetup.enableGraphicalApps) (with pkgs; [
    xss-lock
    brightnessctl
    playerctl
    lightlocker
    dbus
    xclip
    maim
    feh
    dmenu
  ]);
}
