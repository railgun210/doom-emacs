(doom!
 :input
 ;;bidi
 ;;chinese
 ;;japanese
 ;;layout

 :completion
 company
 (corfu +orderless)
 ;;helm
 ;;ido
 ivy
 ;;vertico

 :ui
 ;;deft
 doom
 doom-dashboard
 doom-quit
 (emoji +unicode)
 ;;indent-guides
 ligatures
 ;;minimap
 modeline
 ;;nav-flash
 neotree
 ophints
 (popup +defaults)
 smooth-scroll
 tabs
 treemacs
 unicode
 (vc-gutter +pretty)
 vi-tilde-fringe
 window-select
 workspaces
 ;;zen

 :editor
 (evil +everywhere)
 file-templates
 fold
 (format +onsave)
 snippets
 word-wrap

 :emacs
 dired
 electric
 eww
 undo
 vc

 :term
 eshell
 shell
 term
 vterm

 :checkers
 syntax
 (spell +aspell)

 :tools
 debugger
 docker
 editorconfig
 ein
 (eval +overlay)
 lookup
 lsp
 magit
 make
 pass
 pdf
 tmux
 upload

 :os
 (:if (featurep :system 'macos) macos)

 :lang
 emacs-lisp
 (haskell +lsp)
 json
 (java +lsp)
 javascript
 kotlin
 (latex +cdlatex +latexmk +lsp)
 lua
 markdown
 (nix +lsp)
 (org +pretty +download)
 (php +lsp)
 python
 qt
 (ruby +rails)
 (rust +lsp)
 sh
 web
 yaml

 :email
 ;;(mu4e +org +gmail)

 :app
 calendar
 irc
 (rss +org)

 :config
 literate
 (default +bindings +smartparens))
