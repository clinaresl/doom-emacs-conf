;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq
 projectile-project-search-path '("~/lab/" "~/uc3m/"))

;; ;; global configuration parameters
;; (global-set-key "\C-z" 'scroll-one-line-up)
;; (global-set-key "\M-z" 'scroll-one-line-down)

;; ;; Show the function name in those modes supported
;; (which-function-mode)

;; ;; Always end a file with a newline
;; (setq require-final-newline t)

;; ;; Stop at the end of the file, not just add lines
;; (setq next-line-add-newlines nil)

;; ;; functions used to scroll line by line
;; (defun scroll-one-line-up (&optional arg)
;;   "Scroll the selected window up (forward in the text) one line (or N lines)."
;;   (interactive "p")
;;   (scroll-up (or arg 1)))

;; (defun scroll-one-line-down (&optional arg)
;;   "Scroll the selected window down (backward in the text) one line (or N)."
;;   (interactive "p")
;;   (scroll-down (or arg 1)))
