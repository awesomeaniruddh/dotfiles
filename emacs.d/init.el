;; <Alt> to Super and <Cmd> to Meta.
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;; Get rid of the start screen
(setq inhibit-startup-message t)


(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

;; Make the UI cleaner
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Don't indent with tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)

;; Auto reload files from disk
(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
        (package-refresh-contents)
        (package-install 'use-package))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :config

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "<SPC>"))

  (evil-mode 1)

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode)))

(use-package expand-region
  :ensure t
  :defer t
  :init (evil-leader/set-key "v" 'er/expand-region)
  :config
  (setq expand-region-contract-fast-key "V"
	expand-region-reset-fast-key "r"))

(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-load-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

(use-package avy
  :ensure t
  :bind
  ("C-:"   . 'avy-goto-char)
  ("C-'"   . 'avy-goto-char-2)
  ("M-g f" . 'avy-goto-line))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :bind ("M-/" . 'company-complete-common-or-cycle)
  :config (setq company-idle-delay 0))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config (setq flycheck-check-syntax-automatically
                '(mode-enabled idle-change save)))

(use-package lsp-mode
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'lsp-mode)
  :config
  (use-package lsp-flycheck
    :ensure f
    :after flycheck))

(use-package cquery
  :ensure t
  :after lsp-mode
  :config
  (setq cquery-executable "/usr/local/bin/cquery"))

(use-package auctex
  :ensure t)

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))

(use-package magit
  :ensure t
  :config
  (use-package evil-magit
    :ensure t
    :config
    (setq evil-magit-state 'normal)))

;; Proof-general
(load "~/.emacs.d/lisp/PG/generic/proof-site")

;; Haskell
(use-package haskell-mode
  :ensure t)

(use-package intero
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))

;; (use-package liquid-types
;;   :ensure t
;;   :config
;;   (add-hook 'haskell-mode-hook
;;             '(lambda () (flycheck-select-checker 'haskell-liquid)))
;;   (add-hook 'literate-haskell-mode-hook
;;             '(lambda () (flycheck-select-checker 'haskell-liquid)))
;;   (require 'liquid-types)
;;   (add-hook 'haskell-mode-hook
;;             '(lambda () (liquid-types-mode)))
;;   (add-hook 'literate-haskell-mode-hook
;;             '(lambda () (liquid-types-mode))))

;; Rust
(use-package rust-mode
  :ensure t)

;; Idris
(use-package idris-mode
  :ensure t)

;; 80-char rule
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)

;; Markdown Mode
(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy))
