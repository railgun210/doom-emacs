;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! everforest :recipe (:repo "https://github.com/theorytoe/everforest-emacs.git") :pin "ba61a881b5d57810eef76baae01c951d1e6c2ceb")

(package! phpstan
  :recipe (:host github
           :repo "emacs-php/phpstan.el"))

(package! olivetti)

(package! org-fragtog)

(package! org-appear)

(package! org-download)

(package! org-modern)

(package! org-xopp
:recipe (:host github :repo "mahmoodsh36/org-xopp"
:files (:defaults "*.sh")))
