;;
;;                 _    
;;    __   ___.--'_`.   
;;   ( _`.'. -   'o` )    A quite awful emacs config
;;   _\.'_'      _.-'        by: Jalen Moore
;;  ( \`. )    //\`          art by: Veronica Karlsson (Found at: www.asciiart.eu)
;;   \_`-'`---'\\__,    
;;    \`        `-\     
;;     `                  
;;

;; Setup package archives/manager
; Setup straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq package-enable-at-startup nil)
(setq straight-use-package-by-default t)

(require 'package)
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

; Load emacs.org
(use-package org)
(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
