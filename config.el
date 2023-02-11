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
(load-theme 'doom-zenburn t)

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

;; LaTeX
;; ----------------------------------------------------------------------------

;; Definición de snippets para la edición de ficheros .tex/.latex
(set-file-template! "\\.tex$" :trigger "__.tex" :mode 'latex-mode)
(set-file-template! "\\.latex$" :trigger "__.latex" :mode 'latex-mode)

;; Org
;; ----------------------------------------------------------------------------

;; Customization of the major mode org
(setq org-ellipsis " ▽"
      org-hide-emphasis-markers t)

;; ensure that org-bullets-mode is always enabled by default under org-mode
(use-package org-bullets
  :hook ((org-mode) . org-bullets-mode))

;; also, enable variable-pitch-mode en org-mode. Because variable font width is
;; used, it is also customary to modify the appearance because fill-paragraph
;; works on the number of characters
(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

;; however, fixed-pitch-mode should be preferred for some constructs in ore-mode
(with-eval-after-load 'org-faces
  (progn
    (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
    (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
    (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
    (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)))

;; Change the font size used in the headings
(with-eval-after-load 'org-faces (dolist (face '((org-level-1 . 1.44)
                                                 (org-level-2 . 1.32)
                                                 (org-level-3 . 1.2)
                                                 (org-level-4 . 1.2)
                                                 (org-level-5 . 1.2)
                                                 (org-level-6 . 1.2)
                                                 (org-level-7 . 1.2)
                                                 (org-level-8 . 1.2)))
                                   (set-face-attribute (car face) nil
                                                       :font "Cantarell"
                                                       :weight 'regular
                                                       :height (cdr face))))

;; configuring the default applications to use when opening files. In
;; particular, this setting allow okular to be used when opening pdf files
(setq org-file-apps '((auto-mode . emacs)
                      (directory . emacs)
                      ("\\.mm\\'" . default)
                      ("\\.x?html?\\'" . default)
                      ("\\.pdf\\'" . "okular \"%s\"")))

;; Github Copilot
;; ----------------------------------------------------------------------------

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

(setq copilot-enable-predicates nil)
