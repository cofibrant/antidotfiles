{ config, pkgs, ...}:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -U fish_greeting

      set -x COLORTERM truecolor
      set -x TERM xterm-256color

      eval (${pkgs.direnv}/bin/direnv hook fish)
    '';
  };
}
