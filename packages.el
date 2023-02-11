;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

;; install cutting-edge version of org-mode
;; (package! org-plus-contrib)

;; the following line is given to avoid problems with org-plus-contrib and it
;; substitutes the previous one
(package! org-plus-contrib :recipe (:host github :repo "emacs-straight/org"))

;; ...And prevent other packages from pulling org; org-plus-contrib satisfies
;; the dependency already: https://github.com/raxod502/straight.el/issues/352
(package! org :recipe (:local-repo nil))

(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
