;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; tell projectile where are located the different projects
(setq
 projectile-project-search-path '("~/lab/" "~/uc3m/" "~/org/" "~/latex/"
                                  "~/latex/papers/"
                                  "~/lab/go/src/github.com/clinaresl"))

;; enable avy to search in all windows
(setq avy-all-windows t)

;; show the vertical scroll bar by default
(scroll-bar-mode 1)
(setq scroll-bar-mode 'right)

;; Load personal key bindings
(load! "bindings")

;; manual selection of themes
(load-theme 'doom-spacegrey t)

;; Python
;; ----------------------------------------------------------------------------
;; make sure no white spaces are inserted before parenthesis in python-mode
(add-hook
 'python-mode-hook
 (setq parens-require-spaces nil))

;; suddenly, flycheck.el changes the checkers chain and placed flake8 before
;; pylint, which is rather annoying so I just removed it!
(setq-default flycheck-disabled-checkers '(python-flake8))

;; Go
;; ----------------------------------------------------------------------------
(defun my-go-mode-hook ()

  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")

  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)

  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))

  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)

;; Lua
;; ----------------------------------------------------------------------------

;; add support for editing Lua files
(add-to-list 'load-path "~/.emacs.d/.local/elpa/lua-mode-20200405.1305")

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; and enable flymake for lua
(add-to-list 'load-path "~/.emacs.d/.local/elpa/flymake-lua-20170129.154")
(eval-after-load 'lua-mode '(add-hook 'lua-mode-hook 'flymake-lua-setup))
(autoload #'flymake-lua-setup "flymake-lua" nil t)


;; Org
;; ----------------------------------------------------------------------------

;; add support for a latex export class called manual that uses the memory LaTeX
;; style file
(require 'ox-latex)
(add-to-list 'org-latex-classes
         '("manual"
           "\\documentclass[10pt]{memoir}"
           ("\\chapter{%s}" . "\\chapter*{%s}")
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
         )

;; configuring the default applications to use when opening files. In
;; particular, this setting allow okular to be used when opening pdf files
(setq org-file-apps '((auto-mode . emacs)
                      (directory . emacs)
                      ("\\.mm\\'" . default)
                      ("\\.x?html?\\'" . default)
                      ("\\.pdf\\'" . "okular \"%s\"")))
