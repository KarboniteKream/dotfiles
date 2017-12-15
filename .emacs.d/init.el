;;; init.el --- Emacs configuration file.

;;; Commentary:
;;; TODO

;;; Code:

(require 'package)

(setq package-enable-at-startup nil)
(defvar tls-checktrust t)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Can this be omitted?
(require 'use-package)

(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

(use-package exec-path-from-shell
  :ensure t
  :defer 3
  :config
  ;; TODO: Move PATH to .zshenv.
  (setq exec-path-from-shell-check-startup-files nil)
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; Is this included in use-package?
(use-package delight
  :ensure t)

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package evil
  :ensure t
  :init
  (defvar evil-want-C-u-scroll t)
  :config
  (define-key evil-normal-state-map (kbd "<backspace>") 'mode-line-other-buffer)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  (define-key evil-visual-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-visual-state-map (kbd "k") 'evil-previous-visual-line)

  (define-key evil-normal-state-map (kbd "Y")
    (lambda () (interactive) (evil-yank (point) (point-at-eol))))

  (add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

  (use-package evil-commentary
    :ensure t
    :delight
    :config
    (evil-commentary-mode t))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode t))

  (use-package evil-leader
    :ensure t
    :config
    (evil-leader/set-leader "SPC")
    (evil-leader/set-key "l" 'whitespace-mode)
    (evil-leader/set-key "ee"
      (lambda () (interactive) (find-file user-init-file)))

    (evil-leader/set-key "td"
      (lambda () (interactive) (load-theme 'gruvbox-dark-medium)))

    (evil-leader/set-key "tl"
      ;; TODO: Replace lambda with a named function; for which-key.
      (lambda () (interactive) (load-theme 'gruvbox-light-soft)))

    (evil-leader/set-key "SPC"
      (lambda () (interactive) (lazy-highlight-cleanup)))

    (global-evil-leader-mode))

  ;; FIXME: Conflicts with Emacs.
  ;; (use-package evil-numbers
  ;;   :ensure t
  ;;   :config
  ;;   (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  ;;   (define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt))

  (evil-mode t))

(use-package which-key
  :ensure t
  :delight
  :config
  (which-key-mode t))

(use-package editorconfig
  :ensure t
  :delight
  :config
  (editorconfig-mode t))

(use-package undo-tree
  :ensure t
  :delight
  :config
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '((".*" . "~/.emacs.d/undo/")))
  (global-undo-tree-mode))

(use-package php-mode
  :ensure t
  ;; TODO: Add php?
  :mode ("\\.module$" "\\.inc$"))

(use-package rainbow-delimiters
  :ensure t
  :config
  ;; Is it possible to use :mode?
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package hl-todo
  :ensure t
  :config
  (global-hl-todo-mode))

;; (use-package diff-hl
;;   :ensure t
;;   :config
;;   (global-diff-hl-mode))

(use-package yaml-mode
  :ensure t)

(use-package js2-mode
  :ensure t
  :delight "JavaScript"
  :mode "\\.js$"
  :config
  (setq js2-include-node-externs t)
  (setq js2-strict-trailing-comma-warning nil))

(use-package elixir-mode
  :ensure t
  :config
  (use-package alchemist
    :ensure t))

;; FIXME: Very slow for Drupal files.
;; (use-package mmm-mode
;;   :ensure t
;;   ;; :init
;;   ;; (add-to-list 'auto-mode-alist '("\\.php$" . html-mode))
;;   :config
;;   (setq mmm-global-mode 'maybe)
;;   (mmm-add-mode-ext-class 'html-mode "\\.php\\'" 'html-php))

;; TODO: Move to a variable.
(unless (file-exists-p "~/.emacs.d/backups/")
  (make-directory "~/.emacs.d/backups/"))

(unless (file-exists-p "~/.emacs.d/auto-saves/")
  (make-directory "~/.emacs.d/auto-saves/"))

(setq backup-directory-alist '((".*" . "~/.emacs.d/backups/"))
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-saves/" t)))
(setq auto-save-list-file-prefix "~/.emacs.d/auto-saves/list-")

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq inhibit-x-resources t)
(setq inhibit-startup-message t)

;; TODO: Move around to reduce blinking and white screen.
(add-to-list 'default-frame-alist '(width . 110))
(add-to-list 'default-frame-alist '(height . 60))

;; TODO: Change to -1?
(unless (eq system-type 'darwin)
  (menu-bar-mode 0))
(tool-bar-mode 0)
(scroll-bar-mode 0)

(setq ring-bell-function 'ignore)

(global-linum-mode t)
(column-number-mode t)

(setq scroll-conservatively 1000)
(setq scroll-margin 5)

(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 2)))

;; FIXME: Not working?
(setq lazy-highlight-cleanup nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file 'noerror))

;;; init.el ends here
