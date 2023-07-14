{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: with epkgs; [
      use-package
      evil
      evil-collection
      ivy
      counsel
      magit
      nix-mode
      doom-themes
      doom-modeline
      fira-code-mode
      all-the-icons
      envrc
    ];
  };

  home.file.".emacs.d/doom-iro-theme.el".source = ./doom-iro-theme.el;
  home.file.".emacs".source = ./.emacs;
}
