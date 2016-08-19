;;; init.el --- The first thing GNU Emacs runs

;; Decrease the # of times garbage collection is invoked at startup
(setq gc-cons-threshold 250000000);= 250 MB

;; Free up screen real estate early on
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; ALWAYS save files with UNIX-style line endings regardless of OS
(setq-default buffer-file-coding-system 'utf-8-unix)

;; Ignore default regex checks of filenames during startup
(let ((file-name-handler-alist nil))
  (require 'package)
  (setq package-enable-at-startup nil)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)

  ;; Bootstrap `use-package'
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (eval-when-compile
    (require 'use-package))
  (require 'bind-key)
  (require 'diminish)

  (require 'cl) ; Certain, stubborn packages need this...

  ;; Tangle/load the rest of the config
  (org-babel-load-file "~/.emacs.d/conf.org"))

;; Revert garbage collection behavior
(run-with-idle-timer 5 nil (lambda () (setq gc-cons-threshold 1000000)));= 1 MB

;;; init.el ends here
