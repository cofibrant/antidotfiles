{ config, lib, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = with config.antidotfiles.colours; {
        primary = {
          background = "0x${zero}";
          foreground = "0x${light0}";
        };
        normal = {
          black = "0x${black}";
          red = "0x${red}";
          green = "0x${green}";
          yellow = "0x${yellow}";
          blue = "0x${blue}";
          magenta = "0x${magenta}";
          cyan = "0x${cyan}";
          white = "0x${light4}";
        };
        bright = {
          black = "0x${brightBlack}";
          red = "0x${brightRed}";
          green = "0x${brightGreen}";
          yellow = "0x${brightYellow}";
          blue = "0x${brightBlue}";
          magenta = "0x${brightMagenta}";
          cyan = "0x${brightCyan}";
          white = "0x${light1}";
        };
      };
      font = {
        normal = {
          family = "Fira Code";
          style = "Regular";
        };
        bold = {
          family = "Fira Code";
          style = "Bold";
        };
        italic = {
          family = "Fira Code";
          style = "Italic";
        };
        size = 13.0;
      };
      key_bindings = [
        {
          key = "Key3";
          mods = "Alt";
          chars = "#";
        }
      ];
      window.opacity = 1.0;
      scrolling.history = 50000;
      env = {
        TERM = "xterm-256color";
        WINIT_X11_SCALE_FACTOR = "1.0";
      };
    };
  };
}
