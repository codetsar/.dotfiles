(setq inhibit-startup-message t
      scroll-bar-mode -1        ; Disable visible scrollbar
      tool-bar-mode -1          ; Disable the toolbar
      tooltip-mode -1           ; Disable tooltips
      set-fringe-mode 8         ; Give some breathing room
      menu-bar-mode -1          ; Disable the menu bar
      visible-bell nil
      ring-bell-function 'ignore
      blink-cursor-mode nil)

(setq default-frame-alist '((undecorated . t)
                            (drag-internal-border . 1)
                            (internal-border-width . 5)))

(set-face-attribute 'default nil
		    :font "FiraCode Nerd Font Ret"
		    :height 120)

(load-theme 'modus-operandi t):

(desktop-save-mode 1)
(recentf-mode 1)
(setq history-length 25)
(savehist-mode 1)
(save-place-mode 1)
(setq use-dialog-box nil)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)
;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

(global-display-line-numbers-mode 1)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

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

(use-package general)

(general-define-key
 "C-M-j" 'counsel-switch-buffer)

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
	evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-force-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  
;;(define-key emacs-lisp-mode-map (kbd "C-x M-t") 'counsel-load-theme)

;; NOTE: the first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts

(use-package all-the-icons)
(use-package all-the-icons-dired)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(custom-set-variables
 '(package-selected-packages '(doom-modeline counsel ivy command-log-mode))
 '(org-babel-load-languages (quote ((shell . t)
				    (emacs-lisp . t)
				    (python . t)
				    (R . t))))
 '(org-confirm-babel-evaluate nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
