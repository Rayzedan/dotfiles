;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; in ~/.doom.d/config.el
(setq doom-font (font-spec :family "JetBrains Mono" :size 20 :weight 'medium))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(map!
 :n "M-m" #'comment-line)
(setq gc-cons-threshold (* 100 1024 1024))
(setq global-linum-mode t)
(require 'clang-format)
(setq clang-format-style ".clang-format")
(map! :n "M-[" #'lsp-find-declaration)
(map! :n "M-]" #'lsp-find-implementation)
(map! :n "M-p" #'lsp-find-definition)
(defun close-and-kill-this-pane ()
      "If there are multiple windows, then close this pane and kill the buffer in it also."
      (interactive)
      (kill-this-buffer)
      (if (not (one-window-p))
          (delete-window)))
;; (map! :n "SPC o t" #'vterm)
(map! :n "M-s M-s" #'close-and-kill-this-pane)
(c-add-style "my-c-style" '((c-tab-always-indent . t)
                            (c-set-offset 'substatement-open 1)
                            (c-basic-offset . 4)
                            (c-offsets-alist (access-label . 0)
                                             (label . +))))
(setq doom-modeline-vcs-max-length 40)
;; Setting this as the default style:
(setq c-default-style "my-c-style")
(map! :leader
      :desc "copy-to-clipboard"
      "o y" #'copy-to-clipboard)
(map! :leader
      :desc "paste-from-clipboard"
      "o p" #'paste-from-clipboard)
(map! :n "C-M-m" #'clang-format-buffer)
(map! :n "M-n" #'clang-format-region)
(define-key evil-insert-state-map (kbd "TAB") (lambda () (interactive) (up-list)))
(auto-save-visited-mode +1)
;; Copy/past to system clipboard
(defun copy-to-clipboard ()
  "Copies selection to x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard.")
        (call-interactively 'clipboard-kill-ring-save)
        )
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to clipboard.")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
  )

(defun paste-from-clipboard ()
  "Pastes from x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (clipboard-yank)
        (message "graphics active")
        )
    (insert (shell-command-to-string "xsel -o -b"))
    )
  )
(add-hook 'c-mode-hook 'fci-mode)
(add-hook 'c++-mode-hook
          (lambda ()
            (setq lsp-completion-enable-additional-text-edit nil)))
(set 'projectile-track-known-projects-automatically nil)
(defun insert-doxy-template ()
  "Insert a Doxygen comment template for C++."
  (interactive)
  (insert "/**\n")
  (insert " *\n")
  (insert " *\n")
  (insert " */\n")
  (forward-line -2)
  (move-end-of-line 1))
(add-hook 'c++-mode-hook 'turn-off-smartparens-mode)
(add-hook 'c-mode-hook 'turn-off-smartparens-mode)
(add-hook 'c++-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c d") 'insert-doxy-template)))
(add-hook 'sh-mode-hook
          (lambda ()
            (local-unset-key (kbd "C-c C-c"))))
(require 'multiple-cursors)
(global-set-key (kbd "C-c C-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; (after! vterm
;;   (set-popup-rule! "*doom:vterm-popup:main" :size 0.50 :vslot -4 :select t :quit nil :ttl 0 :side 'right)
;;   )
(defun electric-pair ()
      "If at end of line, insert character pair without surrounding spaces.
    Otherwise, just insert the typed character."
      (interactive)
      (if (eolp) (let (parens-require-spaces) (insert-pair)) (self-insert-command 1)))
(add-hook 'c++-mode-hook
              (lambda ()
                (define-key c++-mode-map "(" 'electric-pair)
                (define-key c++-mode-map "[" 'electric-pair)
                (define-key c++-mode-map "{" 'electric-pair)))
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq fci-rule-column 100)
(setq lsp-ui-sideline-position 'left)

;; You can use this hydra menu that have all the commands
(map! :n "C-SPC" 'harpoon-quick-menu-hydra)
(map! :n "C-s" 'harpoon-add-file)

;; And the vanilla commands
(map! :leader "j c" 'harpoon-clear)
(map! :leader "j f" 'harpoon-toggle-file)
(map! :leader "1" 'harpoon-go-to-1)
(map! :leader "2" 'harpoon-go-to-2)
(map! :leader "3" 'harpoon-go-to-3)
(map! :leader "4" 'harpoon-go-to-4)
(map! :leader "5" 'harpoon-go-to-5)
(map! :leader "6" 'harpoon-go-to-6)
(map! :leader "7" 'harpoon-go-to-7)
(map! :leader "8" 'harpoon-go-to-8)
(map! :leader "9" 'harpoon-go-to-9)

(setq lsp-ui-sideline-enable nil)  ; disable lsp-ui-sideline
(assoc-delete-all "Open documentation" +doom-dashboard-menu-sections)
(assoc-delete-all "Open private configuration" +doom-dashboard-menu-sections)
(assoc-delete-all "Open org-agenda" +doom-dashboard-menu-sections)
(add-hook 'markdown-mode 'fundamental-mode 1)
(global-set-key (kbd "C-<down-mouse-1>") nil)
(global-unset-key (kbd "C-<down-mouse-1>"))
(use-package lsp-mode :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
