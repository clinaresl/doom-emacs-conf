;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq
 projectile-project-search-path '("~/lab/" "~/uc3m/" "~/org/"))

;; Load personal key bindings
(load! "bindings")

;; manual selection of themes
(load-theme 'doom-spacegrey t)
