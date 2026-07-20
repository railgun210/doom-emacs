(setq doom-font (font-spec :family "Cozette" :weight 'medium :height 120)
      doom-big-font (font-spec :family "Overpass Nerd Font" :height 140)
      doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :height 1.2))

(setq doom-theme 'doom-nebula-blue)

;; Got tired of seeing line numbers in org mode, but you don't have to set this if you don't care.
(setq display-line-numbers-type t)
;; Set tabs to only 2 everytime you use the '>' key.
(setq evil-shift-width 2)

(set-frame-parameter nil 'alpha-background 80)
(add-to-list 'default-frame-alist '(alpha-background . 80))

(setq fancy-splash-image (concat doom-user-dir "M-x_butterfly.png"))

(setq org-directory "~/Dropbox/org-notes/")

(when (member "Cozette" (font-family-list))
  (set-face-attribute 'default nil :font "Overpass Nerd Font" :height 100)
  (set-face-attribute 'fixed-pitch nil :family "Cozette" :weight 'medium))
(when (member "Overpass Nerd Font" (font-family-list))
  (set-face-attribute 'variable-pitch nil :family "Overpass Nerd Font" :height 1.2))

(after! org
  (global-org-modern-mode)
  (after! org-modern
    (setq org-modern-star '("◉" "○" "◆" "✿")
          org-modern-list '((?+ . "•") (?- . "–") (?* . "◦"))
          org-modern-hide-stars nil)
 
    (setq org-modern-table nil
          org-modern-block-name
          '((t . t)
            ("src" . "⌘")
            ("example" . "»")
            ("quote" . "❝")
            ("export" . "󰈇"))))

(require 'org-download)
(setq org-download-method 'directory
      org-download-image-dir "~/org-notes/.resources"
      org-download-timestamp "org_%Y%m%d-%H%M%S_"
      org-download-heading-lvl nil
      org-image-actual-width 900
      org-download-screenshot-method
      "wl-paste --type image/png > %s")

;; Always display inline images
(setq org-startup-with-inline-images t)
;; Refresh images after executing code blocks or edits
(add-hook 'org-babel-after-execute-hook #'org-display-inline-images)
;; Refresh images when reverting buffers (e.g. after git pull)
(add-hook 'after-revert-hook #'org-display-inline-images)

(defun create-png-xournal-file (&optional only-export)
"Creates a png from a xournal file and inserts it into the buffer."
  (interactive "P")
  (let ((file-name (expand-file-name
                    (file-name-sans-extension
                     (read-file-name ".xopp file to convert: ")))))
    (shell-command (format "xournalpp --create-img=%s.png %s.xopp"
                           file-name file-name))
    (unless only-export
     (kill-new (concat "[[" file-name ".png" "]]"))
     (yank)
     (org-display-inline-images))
    (org-redisplay-inline-images)))
(require 'org-xopp) (org-xopp-setup)

(dolist (face '((org-level-1 . 1.30)
                (org-level-2 . 1.25)
                (org-level-3 . 1.15)
                (org-level-4 . 1.05)
                (org-level-5 . 1.05)
                (org-level-6 . 1.05)
                (org-level-7 . 1.05)
                (org-level-8 . 1.05)))
  (set-face-attribute (car face) nil
                      :font "Overpass Nerd Font"
                      :weight 'bold
                      :height (cdr face)))

;; Make the document title bigger
(set-face-attribute 'org-document-title nil
                    :font "Overpass Nerd Font"
                    :weight 'bold
                    :height 1.1)
;; This will fix spacing issues when a line of text contains both variable and fixed-pitch text.
(require 'org-indent)
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
;; Ensure that some parts of Org will always use fixed-pitch fonts even if variable-pitch-mode is on
(set-face-attribute 'org-block nil            :foreground nil :inherit
                    'fixed-pitch :height 0.85)
(set-face-attribute 'org-code nil             :inherit '(shadow fixed-pitch) :height 0.85)
(set-face-attribute 'org-indent nil           :inherit '(org-hide fixed-pitch) :height 0.85)
(set-face-attribute 'org-verbatim nil         :inherit '(shadow fixed-pitch) :height 0.85)
(set-face-attribute 'org-special-keyword nil  :inherit '(font-lock-comment-face
                                                         fixed-pitch))
(set-face-attribute 'org-meta-line nil        :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil         :inherit 'fixed-pitch)
(add-hook 'org-mode-hook 'variable-pitch-mode)

;; enable a live PDF viewer
(setq +latex-viewers '(pdf-tools))
(setq org-preview-latex-default-process 'dvisvgm)
;; Latex lsp reader
(setq lsp-tex-server 'digestif)

(add-hook! 'org-mode-hook 'org-fragtog-mode)
(setq org-startup-with-latex-preview t
      org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

(setq org-adapt-indentation t
      org-hide-leading-stars t
      org-pretty-entities t)

;; For source code blocks, make Org display contents using the major mode of the relevant language.
;; This also makes TAB behave like normal in code blocks.
(setq org-src-fontify-natively t
	org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)

(use-package org-appear
  :commands (org-appear-mode)
  :hook     (org-mode . org-appear-mode)
  :config
  (setq org-hide-emphasis-markers t)  ; Must be activated for org-appear to work
  (setq org-appear-autoemphasis   t   ; Show bold, italics, verbatim, etc.
        org-appear-autolinks      t   ; Show links
	  org-appear-autosubmarkers t)) ; Show sub- and superscript

(setq org-log-done                       t
      org-auto-align-tags                t
	org-tags-column                    -80
	org-fold-catch-invisible-edits     'show-and-error
	org-special-ctrl-a/e               t
	org-insert-heading-respect-content t)

;; Prettify Symbols 
(defun my/prettify-symbols-setup ()
  ;; Checkboxes
  (push '("[ ]" . "") prettify-symbols-alist)
  (push '("[X]" . "") prettify-symbols-alist)
  (push '("[-]" . "" ) prettify-symbols-alist)
  
  ;; org-abel
  (push '("#+BEGIN_SRC" . ?≫) prettify-symbols-alist)
  (push '("#+END_SRC" . ?≫) prettify-symbols-alist)
  (push '("#+begin_src" . ?≫) prettify-symbols-alist)
  (push '("#+end_src" . ?≫) prettify-symbols-alist)
  
  (push '("#+BEGIN_QUOTE" . ?❝) prettify-symbols-alist)
  (push '("#+END_QUOTE" . ?❞) prettify-symbols-alist)

  ;; Drawers
  (push '(":PROPERTIES:" . "") prettify-symbols-alist)
  
  ;; Tags
  (push '(":projects:" . "") prettify-symbols-alist)
  (push '(":work:"     . "") prettify-symbols-alist)
  (push '(":inbox:"    . "") prettify-symbols-alist)
  (push '(":task:"     . "") prettify-symbols-alist)
  (push '(":thesis:"   . "") prettify-symbols-alist)
  (push '(":uio:"      . "") prettify-symbols-alist)
  (push '(":emacs:"    . "") prettify-symbols-alist)
  (push '(":learn:"    . "") prettify-symbols-alist)
  (push '(":code:"     . "") prettify-symbols-alist)

  (prettify-symbols-mode))

(add-hook 'org-mode-hook        #'my/prettify-symbols-setup)
(add-hook 'org-agenda-mode-hook #'my/prettify-symbols-setup)

;; Makes text fill the screen daptively to make long lines of text adapt to the size of whatever window.
;; Breaks lines instead of truncates them
(add-hook 'org-mode-hook 'visual-line-mode)
;; Disable line numbers in org mode
(add-hook 'org-mode-hook #'doom-disable-line-numbers-h)

(setq olivetti-body-width 100) ;; or a float, like 0.6 for 60% of window width
(add-hook 'org-mode-hook #'olivetti-mode)
(add-hook 'markdown-mode-hook #'olivetti-mode))

(after! ispell
  (setq ispell-program-name "aspell"
        ispell-dictionary "en"))

(after! spell-fu
  (setq spell-fu-idle-delay 0.5)
  (set-face-attribute 'spell-fu-incorrect-face nil
                      :foreground nil
                      :background nil
                      :underline '(:style wave :color "goldenrod")))

;; Make dividers appear even if only one window is present
(setq window-divider-default-places t)
;; Enable window-divider globally
(window-divider-mode 1)
;; Gap width (like i3 inner gaps)
(setq window-divider-default-bottom-width 10
      window-divider-default-right-width 10
      window-divider-default-places t)



(after! org
  (setq org-directory "~/org-notes/"
        org-agenda-files
        '("~/Dropbox/org-notes/")))

(setq +doom-dashboard-menu-sections
'(("Recently opened files" :icon
   (nerd-icons-faicon "nf-fa-file_text" :face 'doom-dashboard-menu-title)
   :action recentf-open-files)
  ("Reload last session" :icon
   (nerd-icons-octicon "nf-oct-history" :face 'doom-dashboard-menu-title)
   :when
   (cond
    ((modulep! :ui workspaces)
     (file-exists-p
      (expand-file-name persp-auto-save-fname persp-save-dir)))
    ((require 'desktop nil t)
     (file-exists-p
      (desktop-full-file-name))))
   :action doom/quickload-session)
  ("Open org-agenda" :icon
   (nerd-icons-octicon "nf-oct-calendar" :face 'doom-dashboard-menu-title)
   :when
   (fboundp 'org-agenda)
   :action org-agenda)
  ("Open project" :icon
   (nerd-icons-octicon "nf-oct-briefcase" :face 'doom-dashboard-menu-title)
   :action projectile-switch-project)
  ("Jump to bookmark" :icon
   (nerd-icons-octicon "nf-oct-bookmark" :face 'doom-dashboard-menu-title)
   :action bookmark-jump)
  ("Open private configuration" :icon
   (nerd-icons-octicon "nf-oct-tools" :face 'doom-dashboard-menu-title)
   :when
   (file-directory-p doom-user-dir)
   :action doom/open-private-config)
  ("Open documentation" :icon
   (nerd-icons-octicon "nf-oct-book" :face 'doom-dashboard-menu-title)
   :action doom/help)))

(after! lsp-php
  ;; Disable other PHP LSPs over TRAMP
  (setq lsp-disabled-clients
        '(iph-tramp phpactor-tramp serenata-tramp php-ls-tramp semgrep-ls-tramp))

  (lsp-register-client
   (make-lsp-client
    :new-connection
    (lsp-tramp-connection
     '("/home/railgun/.npm-global/bin/intelephense" "--stdio"))
    :major-modes '(php-mode)
    :remote? t
    :priority 10
    :server-id 'intelephense-remote)))

(after! tramp
  ;; Keep PATH minimal to avoid TRAMP slowdowns
  (setq tramp-remote-path
        '("/home/railgun/.npm-global/bin"
          "/usr/bin"
          "/usr/local/bin"
          tramp-own-remote-path)))

(after! lsp-mode
  (setq lsp-enable-file-watchers nil)
  (setq lsp-file-watch-threshold 500)) ; Lower the threshold for what counts as "too many files")
(setq lsp-remote-path-check nil)

(with-eval-after-load 'tramp
  (with-eval-after-load 'compile
    (remove-hook 'compilation-mode-hook #'tramp-compile-disable-ssh-controlmaster-options)))

(setq magit-commit-show-diff nil)
;; don't show git variables in magit branch
(setq magit-branch-direct-configure nil)
;; don't automatically refresh the status buffer after running a git command
(setq magit-refresh-status-buffer nil)

(defun memoize-remote (key cache orig-fn &rest args)
  "Memoize a value if the key is a remote path."
  (if (and key
           (file-remote-p key))
      (if-let ((current (assoc key (symbol-value cache))))
          (cdr current)
        (let ((current (apply orig-fn args)))
          (set cache (cons (cons key current) (symbol-value cache)))
          current))
    (apply orig-fn args)))

;; Memoize current project
(defvar project-current-cache nil)
(defun memoize-project-current (orig &optional prompt directory)
  (memoize-remote (or directory
                       project-current-directory-override
                       default-directory)
                   'project-current-cache orig prompt directory))

(advice-add 'project-current :around #'memoize-project-current)

;; Memoize magit top level
(defvar magit-toplevel-cache nil)
(defun memoize-magit-toplevel (orig &optional directory)
  (memoize-remote (or directory default-directory)
                   'magit-toplevel-cache orig directory))
(advice-add 'magit-toplevel :around #'memoize-magit-toplevel)

;; memoize vc-git-root
(defvar vc-git-root-cache nil)
(defun memoize-vc-git-root (orig file)
  (let ((value (memoize-remote (file-name-directory file) 'vc-git-root-cache orig file)))
    ;; sometimes vc-git-root returns nil even when there is a root there
    (when (null (cdr (car vc-git-root-cache)))
      (setq vc-git-root-cache (cdr vc-git-root-cache)))
    value))
(advice-add 'vc-git-root :around #'memoize-vc-git-root)

;; memoize all git candidates in the current project
(defvar $counsel-git-cands-cache nil)
(defun $memoize-counsel-git-cands (orig dir)
  ($memoize-remote (magit-toplevel dir) '$counsel-git-cands-cache orig dir))
(advice-add 'counsel-git-cands :around #'$memoize-counsel-git-cands)

(after! eww
  (add-to-list 'display-buffer-alist
               '("\\*eww\\*"
                 (display-buffer-reuse-window
                  display-buffer-pop-up-window))))

(setq sql-connection-alist
      '((my-remote-db
         (sql-product 'mysql)
         (sql-port 3306)                   ; 5432 for Postgres, 3306 for MySQL
         (sql-server "192.168.50.179")
         (sql-user "wordpress")
         (sql-database "wordpress"))))

(defun profiler-report-expand-all ()
   "Expand all entries in the profiler report recursively."
   (interactive)
   (thread-last
     (buffer-list)
     (seq-filter
      (lambda (b)
        (string-match-p
         "\\*\\(CPU\\|Memory\\)-Profiler-Report.*\\*"
         (buffer-name b))))
     (seq-do
      (lambda (b)
        (with-current-buffer b
          (goto-char (point-min))
          (while (not (eobp))
            (profiler-report-expand-entry)
            (profiler-report-next-entry))
          (goto-char (point-min)))))))

 (add-hook! 'profiler-report-mode-hook
   (run-with-timer
    0.1 nil
    #'profiler-report-expand-all))


(defadvice! helpful-for-describe-function-a (_fn &rest args)
    "Replace describe-function with better alternative.
Works in the Profiler and Transients."
    :around #'describe-function
    (apply #'helpful-symbol args))

(map! :leader
      ;; Home / Dashboard
      ;; Ewww
      (:prefix-map ("e" . "eww")
        :desc "Reload website" "r" #'eww-reload)
      ;; Dired File Management
      (:prefix-map ("f" . "file")
       :desc "Create directory" "+" #'dired-create-directory
       :desc "Rename directory" "n" #'dired-rename-subdir
       :desc "Create file" "t" #'dired-create-files
       :desc "Mark Directory" "x" #'dired-mark)
      (:prefix-map ("x" . "home")
       :desc "Switch to dashboard" "h" #'+doom-dashboard/open)
      ;; Org mode
      (:prefix-map ("m" . "org")
       ;; Capture / insert
       (:prefix ("c" . "capture")
        :desc "Paste org screenshot" "p" #'org-download-screenshot
        :desc "Insert Xournal figure" "x" #'org-xopp-new-figure)
       ;; Display / visuals
       (:prefix ("d" . "display")
        :desc "Display inline images" "i" #'org-display-inline-images)))
