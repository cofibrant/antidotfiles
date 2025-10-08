{
  pkgs,
  config,
  lib,
  ...
}:

with lib;
with config.antidotfiles;
{
  # TODO(@cofibrant) switch to managing `ghostty` installation via `nix`
  # if / when package is released
  # (c.f. https://github.com/ghostty-org/ghostty/discussions/2824)
  programs.ghostty.enable = !pkgs.stdenv.isDarwin && guiUtils.enable;
  home.file = mkIf guiUtils.enable {
    # Config reference https://ghostty.org/docs/config/reference
    ".config/ghostty/config".text = ''
      font-family = FiraCode Nerd Font Mono
      font-thicken
      font-size = 13
      scrollback-limit = 500000
      theme = iro
    '';
    ".config/ghostty/themes/iro".text = with colours; ''
      palette = 0=#${zero}
      palette = 1=#${red}
      palette = 2=#${green}
      palette = 3=#${yellow}
      palette = 4=#${blue}
      palette = 5=#${magenta}
      palette = 6=#${cyan}
      palette = 7=#${brightYellow}
      palette = 8=#${black}
      palette = 9=#${brightRed}
      palette = 10=${brightGreen}
      palette = 11=#${brightYellow}
      palette = 12=#${brightBlue}
      palette = 13=#${brightMagenta}
      palette = 14=#${brightCyan}
      palette = 15=#${brightBlack}

      background = #${zero}
      foreground = #${light0}
      cursor-color = #${light0}
      cursor-text = #${zero}
      selection-background = #${dark2}
      selection-foreground = #${light1}
    '';
  };
}
