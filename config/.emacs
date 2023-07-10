(require 'use-package)

;; Disable some UI nonsense

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10) ;; Add some padding

(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq use-dialog-box nil)

;; Make <escape> behave sensibly

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Bring back numbers

(global-display-line-numbers-mode t)
(column-number-mode)

;; Parentheses

(show-paren-mode)

;; Unicode

(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Theme settings

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-iro t))

;; Highlight line

(require 'hl-line)
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :background "#41454d")

;; Font

(set-face-attribute 'default nil :font "Fira Code" :height 120)
(use-package fira-code-mode :hook prog-mode)

;; Magit

(use-package magit)

;; Evil mode

(use-package evil
  :demand t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (define-key evil-insert-state-map (kbd "M-3") (lambda () (interactive) (insert "#")))
  (evil-mode t))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Nix mode

(use-package nix-mode
  :mode "\\.nix\\'")

;; Ivy

(use-package ivy
  :diminish
  :demand t
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-p" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-switch-buffer-kill))
  :config
  (ivy-mode 1))

;; Agda mode

(if (executable-find "agda")
    (load-file (let ((coding-system-for-read 'utf-8))
		      (shell-command-to-string "agda-mode locate"))))
    (setq agda2-program-args '("+RTS" "-M6G" "-H3.5G" "-A128M" "-RTS"))

;; Whitespace

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(setq require-final-newline t)
