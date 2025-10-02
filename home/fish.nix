{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -U fish_greeting

      set -Ux COLORTERM truecolor
      set -Ux TERM xterm-256color



      eval (${pkgs.direnv}/bin/direnv hook fish)

      fish_vi_key_bindings
    ''
    + (
      if config.antidotfiles.xcodeTools.enable then
        ''
          set -Ux MACOS_SYSROOT (xcrun --sdk macosx --show-sdk-path)
        ''
      else
        ""
    );
  };
}
