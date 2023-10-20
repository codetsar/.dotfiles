;;;-*- lexical-binding:t -*-

;;; startup
(setq gc-cons-threshold (* 100 1000 1000))
(add-hook 'emacs-startup-hook
    #'(lambda ()
        (message "Startup in %s sec with %d garbage collections"
            (emacs-init-time "%.2f")
            gcs-done)))
(require 'server)
(unless (server-running-p)
(server-start))
(setq inhibit-startup-message t
        tool-bar-mode nil
        tooltip-mode nil
        visible-bell nil
        ring-bell-function 'ignore
        blink-cursor-mode nil
        default-frame-alist '((undecorated . t)
                            (drag-internal-border . 1)
                            (internal-border-width . 5)))
(menu-bar-mode -1)

;;; for lsp performance
(setq read-process-output-max (* 1024 1024))

(global-display-line-numbers-mode)
(menu-bar--display-line-numbers-mode-relative)
;;(setq display-line-numbers 'relative)

(setq make-backup-files nil)
(setq auto-save-default nil)

;;; don't add Custom settings here
(setq custom-file "~/dotfiles/emacs/emacs-custom.el")
(load custom-file t)

(require 'recentf)
(setq recent-filename-handlers
      (append '(abbreviate-file-name) recentf-filename-handlers))
(recentf-mode)
(setq global-auto-revert-mode 1               ; Revert buffers when the underlying file has changed
      global-auto-revert-non-file-buffers t)  ; Revert Dired and other buffers


(use-package modus-themes
    :init (load-theme 'modus-operandi t))

(use-package doom-themes
:disabled
:config
(setq doom-themes-enable-bold t doom-themes-enable-italic nil)
            (load-theme 'doom-nord t)
            (doom-themes-org-config))

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(setq use-package-always-ensure t)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(require 'package)
(use-package command-log-mode)

(use-package ivy
:diminish
:bind (("C-s" . swiper)
        :map ivy-minibuffer-map
        ("TAB" . ivy-alt-done)
        ("C-l" . ivy-alt-done)
        ("C-j" . ivy-next-line)
        ("C-k" . ivy-previous-line)
        :map ivy-switch-buffer-map
        ("C-k" . ivy-previous-line)
        ("C-l" . ivy-done)
        ("C-d" . ivy-switch-buffer-kill)
        :map ivy-reverse-i-search-map
        ("C-k" . ivy-previous-line)
        ("C-d" . ivy-reverse-i-search-kill))
:config
(ivy-mode 1))

(use-package swiper)
(use-package general)
(general-define-key
    "C-M-j" 'counsel-switch-buffer)

(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history nil))

(use-package evil
    :demand t
    :bind (("<escape>" . keyboard-escape-quit))
    :init
    (setq evil-want-keybinding nil)
    :config
    (evil-mode 1)
    (setq evil-search-module 'evil-search)
    (setq evil-undo-system 'undo-tree)
    (setq sentence-end-double-space nil))

(global-undo-tree-mode)
(evil-set-undo-system 'undo-tree)

(use-package evil-collection ;; Shift-S + delimiter
    :after evil
    :config
    (setq evil-want-integration t)
    (evil-collection-init))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(setq my-todo-file "~/org/todo.org"
      my-schd-file "~/org/schedule.org")
(setq org-capture-templates
      '(("m" "Score" entry (file "~/org/scores.org")
	 "* score\ndate: %U\nwpm: %i\nacc (%): %i\ntime (s): %i")))

;; RET will folow links in org-mode files
;;(setq org-return-follows-link t)

(setq org-list-allow-alphabetical t
      org-export-with-toc nil
      org-image-actual-width nil)

(setq org-hide-emphasis-markers t)

;; citations
(setq org-cite-global-bibliography (list (expand-file-name "~/Library/refs.bib")))

(use-package rustic
:ensure t
:config
(setq rustic-lsp-server 'rust-analyzer))

(use-package plantuml-mode)
(setq org-plantuml-jar-path (expand-file-name "/home/yar/dotfiles/emacs/plantuml.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

(setq org-log-done 'time)
(setq org-agenda-files '("~/org/"))
(setq calendar-week-start-day 1)
(setq org-startup-indented t)
(setq org-babel-python-command "python3.12")
(setq org-babel-load-languages
   '((shell . t)
     (emacs-lisp . t)
     (python . t)
     (R . t)
     (java . t)
     (haskell . t)
     (plantuml . t)
     (dot . t)))
 (setq org-confirm-babel-evaluate nil)
