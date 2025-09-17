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
        style = "bold fg:black bg:blue";
        symbol = "";
        format = "[]($style inverted fg:prev_bg)[$symbol $branch(:$remote_branch) ]($style)";
        truncation_length = 10;
      };
      git_commit = {
        format = "[]($style inverted fg:prev_bg)[ $hash$tag ]($style)";
        style = "bold fg:black bg:orange";
        tag_symbol = "  ";
        only_detached = true;
      };
      git_metrics = {
        disabled = true;
        only_nonzero_diffs = false;
        added_style = "bold fg:black bg:green";
        deleted_style = "bold fg:black bg:red";
        format = lib.concatStrings [
         "[]($added_style inverted fg:prev_bg)[$added ]($added_style)" 
         "[]($deleted_style inverted fg:prev_bg)[$deleted ]($deleted_style)"
        ];
      };
      git_status = {
        style = "bold fg:black bg:purple";
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
        style = "bold fg:black bg:yellow";
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
          orange = "#${orange}";
        };
      };
    };
  };
}
