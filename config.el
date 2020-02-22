;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; tell projectile where are located the different projects
(setq
 projectile-project-search-path '("~/lab/" "~/uc3m/" "~/org/" "~/latex/" "~/latex/papers/"))

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
