(defun golang-config () 
  (add-to-list 'load-path "/usr/local/go/misc/emacs" t)
  (add-to-list 'load-path "~/Code/go/src/github.com/nsf/gocode/emacs" t)
  (require 'go-autocomplete)
  (require 'auto-complete-config)
  (require 'go-mode-load)
  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "\C-c\C-r") 'go-remove-unused-imports)))
  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "\C-ci") 'go-goto-imports)))
  (add-hook 'before-save-hook 'gofmt-before-save))

(defun scss-config ()
  (setq scss-compile-at-save nil))

(defun scala-config ()
  (setq scala-indent:use-javadoc-style t)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))

(defun orgmode-config ()
  (setq org-default-notes-file "~/notes.org")
  (define-key global-map "\C-cc" 'org-capture)
  (setq org-mobile-directory "~/Dropbox/MobileOrg")
  (global-set-key "\C-ca" 'org-agenda))

(defun javascript-config ()
  (custom-set-variables '(coffee-tab-width 2))
  (setq js-indent-level 2))

(defun haskell-config ()
  (setq haskell-stylish-on-save t)
  (setq haskell-font-lock-symbols t)) 

(defun shortcuts-config ()
  (smex-initialize)
  (global-set-key "\C-x\C-m" 'smex)
  (global-set-key "\C-c\C-m" 'smex)
  
  (global-set-key "\C-w" 'backward-kill-word)
  (global-set-key "\C-c\C-g" 'magit-status)
  (global-set-key "\C-x\C-k" 'kill-region)
  (global-set-key "\C-c\C-k" 'kill-region)
  ;; Never use this function (goal-set-column)
  (global-unset-key "\C-x\C-n")


  (defalias 'qrr 'query-replace-regexp)
  (global-set-key [f5] 'call-last-kbd-macro)
  (global-set-key [f7] 'compile)
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)))

(defun markdown-config ()  (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  (add-hook 'markdown-mode 'longlines-mode))

(defun style-config ()
  (require 'color-theme)
  (require 'color-theme-solarized)
  (color-theme-solarized-dark))

(defun clojure-config ()

  (eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'nrepl-mode))

  (eval-after-load 'clojure-mode
    '(font-lock-add-keywords
      'clojure-mode
      (mapcar
       (lambda (pair)
         `(,(car pair)
           (0 (progn (compose-region
                      (match-beginning 0) (match-end 0)
                      ,(cadr pair))
                     nil))))
       '(("\\<fn\\>" ?ƒ)
         ("\\<comp\\>" ?∘)
         ("\\<partial\\>" ?þ)
         ("\\<complement\\>" ?¬)))))


  (require 'cider)
  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)

  (add-hook 'clojure-mode-hook 'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook 'paredit-mode)
  (add-hook 'ielm-mode-hook 'paredit-mode)
  (add-hook 'lisp-mode-hook 'paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'paredit-mode)
  (add-hook 'scheme-mode-hook 'paredit-mode)

  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook 'rainbow-delimiters-mode)
  (add-hook 'ielm-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode))

(defun c++-config ()
  (require 'google-c-style)
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  ;;
  ;; If you want the RETURN key to go to the next line and space over
  ;; to the right place, add this to your .emacs right after the
  ;; load-file:
  ;;
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)


  (add-to-list 'load-path (concat "~/.emacs.d/" "AC"))
  (require 'auto-complete-config)
  (add-to-list 'ac-dictionary-directories (concat "~/.emacs.d/" "AC/ac-dict"))

  (require 'auto-complete-clang)

  (setq ac-auto-start nil)
  (setq ac-quick-help-delay 0.5)
  (ac-set-trigger-key "TAB")
  (define-key ac-mode-map  [(control tab)] 'auto-complete)
  (defun my-ac-config ()
    (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
    (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
    ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
    (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
    (add-hook 'css-mode-hook 'ac-css-mode-setup)
    (add-hook 'auto-complete-mode-hook 'ac-common-setup)
    (global-auto-complete-mode t))
  (defun my-ac-cc-mode-setup ()
    (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
  (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
  ;; ac-source-gtags
  (my-ac-config))

(defun latex-config ()
  (add-hook 'LaTeX-mode-hook (lambda ()
                               (TeX-run-style-hooks "amsmath" "amsthm" "latex2e")))
  (add-hook 'LaTeX-mode-hook (lambda ()
                               (TeX-fold-mode 1)))
  (add-hook 'LaTeX-mode-hook
            '(lambda ()
               (define-key LaTeX-mode-map (kbd "$") 'self-insert-command)))
  ;; (add-hook 'LaTeX-mode-hook 'electric-pair-mode)
  (add-hook 'LaTeX-mode-hook 'rainbow-delimiters-mode)
  (setq TeX-electric-sub-and-superscript t)
  (setq TeX-PDF-mode t)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (setq TeX-source-correlate-method 'synctex)
  (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (LaTeX-add-environments
               '("exmp" LaTeX-env-label)
               '("defn" LaTeX-env-label)
               '("thm" LaTeX-env-label))))
  (setq-default TeX-master nil) 
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-view-program-list '(("OS X Preview" "open %o")))
  (setq TeX-view-program-selection '((output-pdf "OS X Preview")))

  

  (setq TeX-parse-self t)
  (setq TeX-auto-save t)
  (setq LaTeX-command-style '(("" "%(PDF)%(latex) -file-line-error %S%(PDFout)"))))

(defun global-config () 
  (require 'projectile)
  (require 'flx-ido)
  (global-flycheck-mode)
  (projectile-global-mode)
  (electric-layout-mode)
  (electric-indent-mode)
  (electric-pair-mode)
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  ;; disable ido faces to see flx highlights.
  (require 'ess-site)
  (require 'yasnippet) ;; not yasnippet-bundle
  (yas-global-mode 1)
  (add-hook 'jade-mode-hook (lambda ()
                              (setq yas/dont-activate t)))
  (add-hook 'org-mode-hook
            #'(lambda ()
                (setq yas/fallback-behavior
                      `(apply ,(lookup-key org-mode-map [tab])))
                (local-set-key [tab] 'yas/expand)
                (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))
  
  ;; disable auto-save and auto-backup
  (setq auto-save-default nil)
  (setq make-backup-files nil)

  (setq ido-use-faces nil))

(defun python-config ()
  (require 'nose)
  (require 'python-mode)
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:setup-keys t)
  (setq jedi:complete-on-dot t))

(defun r-config ()
  (setq load-path
        (append '("~/.emacs.d/elpa/polymode"  "~/.emacs.d/elpa/polymode/modes")
                load-path))
  (setq ess-nuke-trailing-whitespace-p t))

;; (defun electric-indent-ignore-python (char)
;;   "Ignore electric indentation for python-mode"
;;   (if (equal major-mode 'python-mode)
;;       `no-indent'
;;     nil))
;; (add-hook 'electric-indent-functions 'electric-indent-ignore-python)

(defun electric-indent-ignore-haskell (char)
  "Ignore electric indentation for haskell-mode"
  (if (equal major-mode 'python-mode)
      `no-indent'
    nil))
(add-hook 'electric-indent-functions 'electric-indent-ignore-haskell)

;; ;; Enter key executes newline-and-indent
;; (defun set-newline-and-indent ()
;;   "Map the return key with `newline-and-indent'"
;;   (local-set-key (kbd "RET") 'newline-and-indent))
;; (add-hook 'python-mode-hook 'set-newline-and-indent)

(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))


(defun iy-tab-noconflict ()
  (let ((command (key-binding [tab]))) ; remember command
    (local-unset-key [tab]) ; unset from (kbd "<tab>")
    (local-set-key (kbd "TAB") command))) ; bind to (kbd "TAB")

(defun emms-setup ()
  (require 'emms-setup)
  (emms-standard)
  (emms-default-players))

(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-logical-line)))

(global-set-key (kbd "C-\\") 'comment-or-uncomment-region-or-line)

(add-hook 'ruby-mode-hook 'iy-tab-noconflict)
(add-hook 'markdown-mode-hook 'iy-tab-noconflict)
(add-hook 'org-mode-hook 'iy-tab-noconflict)

(add-hook 'after-init-hook 
          (lambda () 
            (progn
              (require 'auto-complete-config)
              (ac-config-default)
              (scss-config)
              (global-config)
              (scala-config)
              (golang-config)
              (orgmode-config)
              (clojure-config)
              (r-config)
              (haskell-config)
              (shortcuts-config)
              (javascript-config)
              (markdown-config)
              (c++-config)
              (python-config)
              (style-config)
              (latex-config))))

