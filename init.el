(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(setq initial-major-mode 'org-mode)

(setq custom-file (locate-user-emacs-file "custom.el"))

(menu-bar-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(context-menu-mode 1)

(setq-default line-spacing 5)

(setq-default cursor-type '(bar . 3))

(setq inhibit-startup-message t)
(setq warning-minimum-level :emergency)

(setq mac-command-modifier 'meta)
(setq next-line-add-newlines t)

(global-set-key (kbd "M-n") (lambda () (interactive) (next-line 3)))
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 3)))

(setq initial-scratch-message nil)

(use-package spacious-padding
  :init
  (spacious-padding-mode 1))

(use-package expand-region
  :init
  (require 'expand-region)
  :bind (("C-l" . er/expand-region)
         ("C-;" . er/contract-region)))

(use-package avy
  :bind (("C-i" . avy-goto-char-timer)))

(delete-selection-mode 1)

(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-hide-emphasis-markers t)

(global-visual-line-mode 1)

(set-frame-font "Berkeley Mono-14" nil t)

(defun set-org-mode-fonts ()
  (setq buffer-face-mode-face '(:family "SF Pro" :height 180))
  (buffer-face-mode)
  (set-face-attribute 'org-block nil :family "Berkeley Mono" :height 160))
(add-hook 'org-mode-hook 'set-org-mode-fonts)

(blink-cursor-mode 0)

(global-hl-line-mode 1)

(use-package treesit-auto
  :config
  (global-treesit-auto-mode))

(use-package prettier)

(use-package deadgrep)

(use-package projectile)
(setq projectile-project-search-path '("~/Developer/" "~/.emacs.d/"))

(use-package vertico
  :config
  (vertico-mode 1)
  (vertico-mouse-mode 1))

(use-package ef-themes)

(use-package magit)

(use-package atomic-chrome)
(require 'atomic-chrome)
(atomic-chrome-start-server)

(load-theme 'ef-melissa-dark)

(use-package company
  :bind (("C-<return>" . company-complete))
  :config
  (setq company-idle-delay nil)
  (global-company-mode))

(defun ben-save-and-switch-to-web-mode ()
  (let ((original-mode major-mode))
    (web-mode)
    (save-buffer)
    (funcall original-mode)))

(add-hook 'after-save-hook 'ben-save-and-switch-to-web-mode)
(add-hook 'find-file-hook 'ben-save-and-switch-to-web-mode)

(defun ben-prettier ()
  (when (or (string-equal "ts" (file-name-extension buffer-file-name))
            (string-equal "tsx" (file-name-extension buffer-file-name))
	    (string-equal "js" (file-name-extension buffer-file-name))
	    (string-equal "jsx" (file-name-extension buffer-file-name)))
    (prettier-prettify)))

(add-hook 'before-save-hook 'ben-prettier)

(use-package treemacs
  :config
  (treemacs-follow-mode t))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(setq make-backup-files nil)

(setq treemacs-no-png-images t)
