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

;; make sure no white spaces are inserted before parenthesis in python-mode
(add-hook
 'python-mode-hook
 (setq parens-require-spaces nil))
