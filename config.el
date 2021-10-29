;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; tell projectile where are located the different projects

(setq
 projectile-project-search-path '("~/lab/" "~/uc3m/" "~/org/" "~/latex/"
                                  "~/latex/papers/"
                                  "~/lab/go/src/github.com/clinaresl/"))

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
(require 'package)
(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(add-hook
 'python-mode-hook
 (lambda () (setq parens-require-spaces nil)))

;; suddenly, flycheck.el changes the checkers chain and placed flake8 before
;; pylint, which is rather annoying so I just removed it!
;(setq-default flycheck-disabled-checkers '(python-flake8))

;; also register the local templates for python
(set-file-template! "\\.\\(?:py\\|python\\)$" :trigger "__.python" :mode 'python-mode)

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

;; c++
;; ----------------------------------------------------------------------------

;; A continuación se definen varios file templates para ficheros acabados en .h,
;; .hh, .hpp, .cc, .cpp y, por supuesto, para main.cc o main.cpp
(set-file-template! "\\.h\\(?:\\|h\\|pp\\)$" :trigger "__.hh" :mode 'cpp-mode)
(set-file-template! "\\.c\\(?:c\\|pp\\)$" :trigger "__.cc" :mode 'cpp-mode)
(set-file-template! "/main\\.c\\(?:c\\|pp\\)$" :trigger "__main.cc" :mode 'cpp-mode)

;; Org
;; ----------------------------------------------------------------------------

;; add support for a latex export class called manual that uses the memory LaTeX
;; style file
;; (require 'ox-latex)
;; (add-to-list 'org-latex-classes
;;          '("manual"
;;            "\\documentclass[10pt]{memoir}"
;;            ("\\chapter{%s}" . "\\chapter*{%s}")
;;            ("\\section{%s}" . "\\section*{%s}")
;;            ("\\subsection{%s}" . "\\subsection*{%s}")
;;            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;            ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;            ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
;;          )

;; configuring the default applications to use when opening files. In
;; particular, this setting allow okular to be used when opening pdf files
(setq org-file-apps '((auto-mode . emacs)
                      (directory . emacs)
                      ("\\.mm\\'" . default)
                      ("\\.x?html?\\'" . default)
                      ("\\.pdf\\'" . "okular \"%s\"")))
