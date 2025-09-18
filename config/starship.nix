{ lib, config, pkgs, ...}:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = false;
      format = "$username$hostname $directory$character";
      right_format = "$git_branch$git_commit$git_state$git_metrics$git_status";
      scan_timeout = 10;
      palette = "iro";
      character = {
        success_symbol = "[❯](bold blue)[❯](bold green)[❯](bold yellow)[❯](bold red)";
        error_symbol = "[❯❯❯❯](bold red)";
      };
      directory = {
        truncation_length = 2;
        truncate_to_repo = false;
        style = "purple";
        before_repo_root_style = "purple";
        repo_root_style = "bold cyan";
        read_only_style = "red";
        home_symbol = "~";
        read_only = "󰌾";
        fish_style_pwd_dir_length = 1;
      };
      git_branch = {
        style = "bold fg:zero bg:blue";
        symbol = "";
        format = "[]($style inverted fg:prev_bg)[$symbol $branch(:$remote_branch) ]($style)";
        truncation_length = 10;
      };
      git_commit = {
        format = "[]($style inverted fg:prev_bg)[ $hash$tag ]($style)";
        style = "bold fg:zero bg:orange";
        tag_symbol = "  ";
        only_detached = true;
      };
      git_metrics = {
        disabled = true;
        only_nonzero_diffs = false;
        added_style = "bold fg:zero bg:green";
        deleted_style = "bold fg:zero bg:red";
        format = lib.concatStrings [
         "[]($added_style inverted fg:prev_bg)[$added ]($added_style)" 
         "[]($deleted_style inverted fg:prev_bg)[$deleted ]($deleted_style)"
        ];
      };
      git_status = {
        style = "bold fg:zero bg:purple";
        format = "[]($style inverted fg:prev_bg)[$all_status$ahead_behind ]($style)";
        ahead = "";
        behind = "";
        diverged = "";
        conflicted = "=";
        modified = "*";
        renamed = ">";
        staged = "";
        deleted = "-";
        up_to_date = "";
      };
      git_state = {
        style = "bold fg:zero bg:yellow";
        format = "[]($style inverted fg:prev_bg)[ $state ($progress_current/$progress_total) ]($style)";
      };
      username = {
        format = "[$user]($style)";
      };
      hostname = {
        style = "bold green";
        format = "@[$hostname]($style)";
      };
      palettes = {
        iro = with config.antidotfiles.colours; {
          black = "#${black}";
          red = "#${red}";
          green = "#${green}";
          yellow = "#${yellow}";
          blue = "#${blue}";
          purple = "#${magenta}";
          cyan = "#${cyan}";
          orange = "#${orange}";

          brightBlack = "#${brightBlack}";
          brightRed = "#${brightRed}";
          brightGreen = "#${brightGreen}";
          brightYellow = "#${brightYellow}";
          brightBlue = "#${brightBlue}";
          brightPurple = "#${brightMagenta}";
          brightCyan = "#${brightCyan}";
          brightOrange = "#${brightOrange}";

          zero = "#${zero}";
          dark0 = "#${dark0}";
          dark1 = "#${dark1}";
          dark2 = "#${dark2}";
          dark3 = "#${dark3}";
          dark4 = "#${dark4}";

          light0 = "#${light0}";
          light1 = "#${light1}";
          light2 = "#${light2}";
          light3 = "#${light3}";
          light4 = "#${light4}";
        };
      };
    };
  };
}
