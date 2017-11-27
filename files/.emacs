;; User info
(setq user-full-name "Michael Wayne Kearney")
(setq user-mail-address "kearneymw@missouri.edu")

;; Each archive will write its files in a seperate archive directory.
(require 'package)

;; Package archives
(setq package-enable-at-startup nil)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.org/packages/")))

;; Manage package loads
(package-initialize)

;; Modify copy/paste behaviors
(setq select-active-regions t)
(setq mouse-drag-copy-region nil)
(cua-mode 1)
(global-set-key (kbd "<Super> c") 'cua-copy-region)
(global-set-key (kbd "<Super> x") 'cua-cut-region)
(global-set-key (kbd "<Super> v") 'cua-paste)

;; Disable startup noise
(setq exec-path-from-shell-check-startup-files nil)
(setq inhibit-startup-screen t)
(setq-default message-log-max nil)
(kill-buffer "*Messages*")
(setq initial-scratch-message "")

;; Editing behaviors
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)

;; Auto pairs
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)
(setq electric-pair-inhibit-predicate (quote electric-pair-default-inhibit))

;; Scroll
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq scroll-preserve-screen-position t)

;; Zoom in and out
(global-set-key (kbd "C-<wheel-up>") 'text-scale-increase)
(global-set-key (kbd "C-<wheel-down>") 'text-scale-decrease)
(global-set-key (kbd "s-=") 'text-scale-increase)
(global-set-key (kbd "s--") 'text-scale-decrease)

;; Don't scroll past end of lines
(setq next-line-add-newlines nil)

;; Default font
(set-face-attribute 'default nil :font "ConsolasHigh-11" )

;; Show file name in title bar
(setq frame-title-format
      '(buffer-file-name "%f" (dired-directory dired-directory "%b")))

;; Default window size parameters and centered
(let* ((height 60)
       (width 200)
       (top 0)
       (left (/ (- (display-pixel-width)
                   (frame-pixel-width))
                4)))
  (add-to-list 'default-frame-alist (cons 'height height))
  (add-to-list 'default-frame-alist (cons 'width width))
  (add-to-list 'default-frame-alist (cons 'top top))
  (add-to-list 'default-frame-alist (cons 'left left)))

;; Split initial frame horizontally
(split-window-horizontally)

;; Disable auto splitting
(set-frame-parameter nil 'unsplittable t)

;; Customize cursor apperance and behavior
(setq-default cursor-in-non-selected-windows nil)
(blink-cursor-mode 0)
(setq-default cursor-type '(bar . 2))
(setq-default make-pointer-invisible nil)

;; Remove clutter/misc things
(tool-bar-mode -1)
(setq ring-bell-function 'ignore)
(scroll-bar-mode -1)
(setq-default scroll-bar-width 8)
(global-set-key (kbd "<f10>") 'scroll-bar-mode)
(setq-default internal-border-width 8)
(fringe-mode 0)
(setq-default indent-tabs-mode nil)

;; Console behavior
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-scroll-show-maximum-output t)
(setq comint-move-point-for-output t)
;;(setq comint-prompt-read-only t)

;; Truncate lines in comint buffers
(add-hook 'comint-mode-hook
          (lambda()
            (setq truncate-lines 1)))

;; Remove \"Active processes exist\" when killing buffers
(setq confirm-kill-emacs nil)
(add-hook 'comint-exec-hook
          (lambda ()
            (set-process-query-on-exit-flag
             (get-buffer-process (current-buffer)) nil)))

;; Don’t open files from the workspace in a new frame
(setq ns-pop-up-frames nil)

;; THEMES

;; dark theme
;;(load-theme 'base16-onedark t)
;;(set-face-foreground 'font-lock-comment-face "gray50")
;;(set-face-background 'show-paren-match "#36f")

;; Light theme
(load-theme 'base16-google-light t)

(defun linum-format-func (line)
  (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
     (propertize (format (format "%%2d" w) line) 'face 'linum)))
(setq linum-format 'linum-format-func)

;; Programming conviences
(delete-selection-mode 1)
(setq normal-erase-is-backspace nil)
(setq words-include-escapes 1)

;; Auto update disk files that change
(global-auto-revert-mode 1)
(setq auto-revert-interval 5.0)

;; Turn on autofill (paragraphs) mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Quit saving so damn much
(setq delete-auto-save-files t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)
(setq create-lockfiles nil)


;;----------------------------------------------------------------------------;;
;;                                 PACKAGES                                   ;;
;;----------------------------------------------------------------------------;;

;; use-package.el is no longer needed at runtime
(eval-when-compile
  (require 'use-package))

;; Highlight parentheses pairs.
(use-package paren
  :config
  (show-paren-mode 1)
  (set-face-background 'show-paren-match "#36f")
  (set-face-foreground 'show-paren-match "#acf")
  (set-face-attribute 'show-paren-match nil :weight 'extra-bold))

;; Lintr integration
(use-package flycheck)

;; Line numbers (disable if buffer > 3MB)
(use-package linum
  :config
  (global-linum-mode t)
  (setq linum-disabled-modes
        '(inferior-ess-mode mu4e-main-mode mu4e-headers-mode mu4e-view-mode mu4e-compose-mode))

  ;; Dark theme
  ;;(set-face-attribute 'linum nil :height 90 :foreground "gray60" :background "gray22")

  ;; Light theme
  (set-face-attribute 'linum nil :height 90 :foreground "gray60" :background "gray90")

  (defun linum-on ()
    (unless (or (minibufferp)
              (member major-mode linum-disabled-modes)
              (> (buffer-size) 3000000))
      (linum-mode 1))))

;; Dark theme
;;(set-face-background 'vertical-border "gray20")
;;(set-face-foreground 'vertical-border (face-background 'vertical-border))

;; Light theme
(set-face-background 'vertical-border "gray60")
(set-face-foreground 'vertical-border (face-background 'vertical-border))

;; Multiple cursors
(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)))

;; File icons
(use-package all-the-icons)

;; Neotree
(use-package neotree
  :bind (([f8] . neotree-toggle))
  :config
  (setq neo-smart-open t)
  (setq neo-show-hidden-files t)
  (setq neo-theme "icons")
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (set-face-foreground 'neo-dir-link-face "#00a0bb")
  (set-face-foreground 'neo-file-link-face "#666666")
  (set-face-foreground 'neo-header-face "black")
  (set-face-foreground 'neo-root-dir-face "#ff7700")
  (defun text-scale-twice ()
    (interactive)(progn(text-scale-adjust 0)(text-scale-decrease 1.25)))
  (add-hook 'neo-after-create-hook (lambda (_)(call-interactively 'text-scale-twice))))

;; http://www.emacswiki.org/emacs/EmacsSpeaksStatistics
(use-package ess
  :init (require 'ess-site)
  :config
  ;; Customize emacs
  (setq ess-eval-visibly 'nowait)
  (setq ess-eval-empty t)
  (setq ess-ask-for-ess-directory nil)
  (setq ess-local-process-name "R")
  (setq ess-default-style 'RStudio)
  (setq ess-help-pop-to-buffer nil)
  (setq ess-help-own-frame t)
  (setq tab-complete-in-script t)
  (setq ess-execute-in-process-buffer t)
  (setq ess-help-reuse-window t)

  ;; Roxygen defaults
  (setq ess-roxy-str "#'")
  (setq ess-roxy-fill-param-p t)
  (setq ess-roxy-template-alist '(("description" . "\n#'\n#' ")
                                  ("param" . "")
                                  ("return" . "")
                                  ("export" . "")
                                  ("examples" . "")))

  ;; Set indent level to 2 spaces
  (defun myindent-ess-hook ()
    (setq ess-indent-level 2))
  (add-hook 'ess-mode-hook 'myindent-ess-hook)

  ;; Save some disk space
  (setq ess-keep-dump-files 'nil)
  (setq ess-delete-dump-files t)
  (setq ess-mode-silently-save nil)

  ;; Eval so it doesn't send lines above/below to console as much
  (defun my-ess-next-code-line ()
    (setq ess-next-code-line '(1 . t)))
  (add-hook 'ess-mode-hook 'my-ess-next-code-line)

  ;; Don't save ess hist files
  (setq ess-history-file nil)

  ;; R console shortcuts
  (add-hook 'inferior-ess-mode-hook
    '(lambda nil
          (define-key inferior-ess-mode-map [\M-up]
              'comint-previous-matching-input-from-input)
          (define-key inferior-ess-mode-map [\M-down]
              'comint-next-matching-input-from-input)))

  ;; Bind eval to shift enter
  (defun my-ess-eval ()
    (interactive)
    (if (and transient-mark-mode mark-active)
        (call-interactively 'ess-eval-region)
      (call-interactively 'ess-eval-line-and-step)))

  (add-hook 'ess-mode-hook
            '(lambda()
               (local-set-key [(shift return)] 'my-ess-eval)))

  ;; Auto assignment behavior
  (defun ess-insert-S-assign-mod ()
    (interactive)
    (let ((ess-S-assign " <- ") (assign-len (length ess-S-assign)))
      (if (and
           (>= (point) (+ assign-len (point-min)))
           (save-excursion
             (backward-char assign-len)
             (looking-at ess-S-assign)))
          (progn
            (delete-char (- assign-len))
            (insert ess-my-smart-key))
        (insert ess-S-assign))))

  (defun ess-smart-lt ()
    (interactive)
    (if (or (looking-at ess-S-assign)
            (ess-inside-string-or-comment-p (point)))
        (insert ess-my-smart-key)
      (ess-insert-S-assign-mod)))

    (add-hook 'R-mode-hook (lambda () (local-set-key ess-my-smart-key 'ess-smart-lt)))
    (add-hook 'inferior-ess-mode-hook (lambda () (local-set-key ess-my-smart-key 'ess-smart-lt)))
    (add-hook 'R-mode-hook (lambda () (local-set-key (kbd "_") nil)))
    (add-hook 'R-mode-hook (lambda () (local-set-key (kbd "<") 'self-insert-command)))
    (add-hook 'inferior-ess-mode-hook (lambda () (local-set-key (kbd "_") nil)))
    (add-hook 'inferior-ess-mode-hook (lambda () (local-set-key (kbd "<") 'self-insert-command)))

    ;; smart underscore
    (setq ess-S-assign " <- ")
    (setq ess-my-smart-key "<")

    ;; Syntax highlighting
    (setq ess-R-font-lock-keywords
          '((ess-R-fl-keyword:modifiers . t)
            (ess-R-fl-keyword:fun-defs . t)
            (ess-R-fl-keyword:keywords . t)
            (ess-R-fl-keyword:assign-ops . t)
            (ess-R-fl-keyword:constants . t)
            (ess-fl-keyword:fun-calls . t)
            (ess-fl-keyword:numbers . t)
            (ess-fl-keyword:operators . t)
            (ess-fl-keyword:delimiters . t)
            (ess-fl-keyword:= . t)
            (ess-R-fl-keyword:F&T . t)
            (ess-R-fl-keyword:%op% . t)))

    ;; (setq inferior-ess-r-font-lock-keywords
    ;;       '((ess-R-fl-keyword:modifiers)
    ;;         (ess-R-fl-keyword:fun-defs)
    ;;         (ess-R-fl-keyword:keywords)
    ;;         (ess-R-fl-keyword:assign-ops)
    ;;         (ess-R-fl-keyword:constants)
    ;;         (ess-fl-keyword:fun-calls)
    ;;         (ess-fl-keyword:numbers)
    ;;         (ess-fl-keyword:operators)
    ;;         (ess-fl-keyword:delimiters)
    ;;         (ess-fl-keyword:=)
    ;;         (ess-R-fl-keyword:F&T)
    ;;         (ess-R-fl-keyword:%op%)))
    (setq font-lock-global-modes '(not inferior-ess-mode))
    (add-hook 'inferior-ess-mode-hook (lambda () (setq truncate-lines t))))


;; auto complete
(use-package auto-complete
  :config
  (global-auto-complete-mode t)
  (setq ac-auto-show-menu 0.3)
  (setq ac-delay 0.3)
  (setq ac-use-quick-help nil)
  (define-key ac-completing-map (kbd "M-h") 'ac-quick-help))

;;; powerline
(use-package powerline
  :config
  (powerline-default-theme)
  (setq powerline-default-separator 'arrow-fade))

;; Markdown mode
(autoload 'markdown-mode "markdown-mode" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;; polymode
(use-package poly-R)
(use-package poly-markdown
  :config
  (add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
  (add-to-list 'auto-mode-alist '("\\.rmarkdown" . poly-markdown+r-mode))
  (defun renderRmd ()
    (interactive)
    (save-excursion
      (message "Rendering %S" (buffer-file-name))
      (setq ess-command (format "rmarkdown::render(%S)" (buffer-file-name)))
      (ess-execute ess-command 'buffer nil nil)))
  (add-hook 'ess-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c C-d C-r") 'renderRmd))))

;; Latex defaults
(setq-default TeX-engine 'xetex)
(setq-default TeX-PDF-mode t)
(add-hook 'LaTeX-mode-hook 'font-lock-mode)
(setq font-latex-deactivated-keyword-classes nil)

;; Set default R version, (i.e. the one launched by typing M-x R <RET>)
(setq inferior-R-program-name "/usr/local/bin/R")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0c3b1358ea01895e56d1c0193f72559449462e5952bded28c81a8e09b53f103f" "b8929cff63ffc759e436b0f0575d15a8ad7658932f4b2c99415f3dde09b32e97" "350dc341799fbbb81e59d1e6fff2b2c8772d7000e352a5c070aa4317127eee94" "b0c5c6cc59d530d3f6fbcfa67801993669ce062dda1435014f74cafac7d86246" "2cfc1cab46c0f5bae8017d3603ea1197be4f4fff8b9750d026d19f0b9e606fae" "6145e62774a589c074a31a05dfa5efdf8789cf869104e905956f0cbd7eda9d0e" "aea30125ef2e48831f46695418677b9d676c3babf43959c8e978c0ad672a7329" "36746ad57649893434c443567cb3831828df33232a7790d232df6f5908263692" default)))
 '(font-latex-deactivated-keyword-classes nil t)
 '(imenu-use-popup-menu nil)
 '(inferior-ess-r-font-lock-keywords
   (quote
    ((ess-S-fl-keyword:prompt)
     (ess-R-fl-keyword:messages)
     (ess-R-fl-keyword:modifiers)
     (ess-R-fl-keyword:fun-defs)
     (ess-R-fl-keyword:keywords)
     (ess-R-fl-keyword:assign-ops)
     (ess-R-fl-keyword:constants)
     (ess-fl-keyword:matrix-labels)
     (ess-fl-keyword:fun-calls)
     (ess-fl-keyword:numbers)
     (ess-fl-keyword:operators)
     (ess-fl-keyword:delimiters)
     (ess-fl-keyword:=)
     (ess-R-fl-keyword:F&T))))
 '(inferior-ess-start-file "~/R/.ess-start")
 '(markdown-command "/usr/local/bin/pandoc")
 '(package-selected-packages
   (quote
    (github-modern-theme flycheck use-package smartparens ess neotree auto-dim-other-buffers all-the-icons auctex-latexmk powerline polymode multiple-cursors markdown-mode ess-smart-underscore base16-theme auto-package-update auto-complete auctex)))
 '(word-wrap t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
