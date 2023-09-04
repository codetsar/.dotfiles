;;; Startup
(setq inhibit-startup-message t
      tool-bar-mode nil
      tooltip-mode nil
      visible-bell nil
      ring-bell-function 'ignore
      blink-cursor-mode nil
      default-frame-alist '((undecorated . t)
                            (drag-internal-border . 1)
                            (internal-border-width . 5)))
;;(set-fringe-mode 8)
;;(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq make-backup-files nil)
(setq auto-save-default nil)

(load-theme 'modus-operandi t)
(global-display-line-numbers-mode 1)

(setq history-length 25
      use-dialog-box nil
      desktop-save-mode 1
      recentf-mode 1
      savehist-mode 1
      save-place-mode 1)

(setq global-auto-revert-mode 1               ; Revert buffers when the underlying file has changed
      global-auto-revert-non-file-buffers t)  ; Revert Dired and other buffers

;;; PACKAGE LIST
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

;;; BOOTSTRAP USE-PACKAGE
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; TODO only if GUI
;; (set-face-attribute 'default nil
;; 		    :font "FiraCode Nerd Font Ret"
;; 		    :height 120)

;; Initialize package sources
(require 'package)

(use-package command-log-mode)

;; M-x package-install RET counsel
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

(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

;;(use-package all-the-icons-dired)

;;(use-package doom-modeline
;;  :ensure t
;;  :init (doom-modeline-mode 1))

(use-package rustic
  :ensure t
  :config
  (setq rustic-lsp-server 'rust-analyzer))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-babel-load-languages
   '((shell . t)
     (emacs-lisp . t)
     (python . t)
     (R . t)
     (dot . t)
     (jupyter . t)))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   '(rustic ox-latex-subfigure csv-mode jupyter zuul magit use-package rust-mode lsp-mode gnuplot general evil doom-modeline counsel command-log-mode all-the-icons-dired)))
;;:'(package-selected-packages '(doom-modeline counsel ivy command-log-mode)))
(setq org-babel-python-command "python3.11")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
