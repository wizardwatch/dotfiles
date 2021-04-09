;; Package Manager
	(require 'package)
	(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                    		("org" . "https://orgmode.org/elpa/")
                         	("elpa" . "https://elpa.gnu.org/packages/")))
	(package-initialize)
	(unless package-archive-contents
	  (package-refresh-contents))
		
		;; Use Package
		(unless ( package-installed-p 'use-package)
		  (package-install 'use-package))
		(require 'use-package)
		(setq use-package-always-ensure t)
;; Packages

	;; selctrum
	(use-package selectrum)
	(selectrum-mode +1)

	;; evil
	(use-package evil)
	(require 'evil)
	(evil-mode 1)	

	;; undo-tree
	(use-package undo-tree)
	(require 'undo-tree)

	;; treemacs
	(use-package treemacs
  		:ensure t
  		:defer t
		:init
  		(with-eval-after-load 'winum
    		(define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  		:config
  		(progn
    			(setq treemacs-collapse-dirs           (if treemacs-python-executable 3 0)
          		treemacs-deferred-git-apply-delay      0.5
 	        	treemacs-directory-name-transformer    #'identity
        	  	treemacs-display-in-side-window        t
          		treemacs-eldoc-display                 t
          		treemacs-file-event-delay              5000
          		treemacs-file-extension-regex          treemacs-last-period-regex-value
          		treemacs-file-follow-delay             0.2
          		treemacs-file-name-transformer         #'identity
          		treemacs-follow-after-init             t
          		treemacs-git-command-pipe              ""
          		treemacs-goto-tag-strategy             'refetch-index
          		treemacs-indentation                   2
          		treemacs-indentation-string            " "
          		treemacs-is-never-other-window         nil
          		treemacs-max-git-entries               5000
          		treemacs-missing-project-action        'ask
          		treemacs-move-forward-on-expand        nil
          		treemacs-no-png-images                 nil
          		treemacs-no-delete-other-windows       t
          		treemacs-project-follow-cleanup        nil
          		treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          		treemacs-position                      'left
          		treemacs-read-string-input             'from-child-frame
          		treemacs-recenter-distance             0.1
          		treemacs-recenter-after-file-follow    nil
          		treemacs-recenter-after-tag-follow     nil
        		treemacs-recenter-after-project-jump   'always
        		treemacs-recenter-after-project-expand 'on-distance
          		treemacs-show-cursor                   nil
          		treemacs-show-hidden-files             t
          		treemacs-silent-filewatch              nil
          		treemacs-silent-refresh                nil
          		treemacs-sorting                       'alphabetic-asc
          		treemacs-space-between-root-nodes      t
          		treemacs-tag-follow-cleanup            t
          		treemacs-tag-follow-delay              1.5
          		treemacs-user-mode-line-format         nil
          		treemacs-user-header-line-format       nil
          		treemacs-width                         35
          		treemacs-workspace-switch-cleanup      nil)

    		;; The default width and height of the icons is 22 pixels. If you are
    		;; using a Hi-DPI display, uncomment this to double the icon size.
    		;;(treemacs-resize-icons 44)

    		(treemacs-follow-mode t)
    		(treemacs-filewatch-mode t)
    		(treemacs-fringe-indicator-mode 'always)
    		(pcase (cons (not (null (executable-find "git")))
                	(not (null treemacs-python-executable)))
      		(`(t . t)
       			(treemacs-git-mode 'deferred))
      		(`(t . _)
       			(treemacs-git-mode 'simple))))
  		:bind
  		(:map global-map
        	("M-0"       . treemacs-select-window)
        	("C-x t 1"   . treemacs-delete-other-windows)
        	("C-x t t"   . treemacs)
        	("C-x t B"   . treemacs-bookmark)
        	("C-x t C-t" . treemacs-find-file)
        	("C-x t M-t" . treemacs-find-tag)))

	(use-package treemacs-evil
  		:after (treemacs evil)
  		:ensure t)
	
	(use-package treemacs-projectile
  		:after (treemacs projectile)
  		:ensure t)

	(use-package treemacs-icons-dired
  		:after (treemacs dired)
  		:ensure t
  		:config (treemacs-icons-dired-mode))

	(use-package treemacs-magit
  		:after (treemacs magit)
  		:ensure t)

	(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  		:after (treemacs persp-mode) ;;or perspective vs. persp-mode
  		:ensure t
  	:config (treemacs-set-scope-type 'Perspectives))
	(treemacs)

	;; Centaur Tabs
	(use-package centaur-tabs
	  :init
	  (setq centaur-taba-enable-keyb-bindings t)
		:demand
  		:config
  		(centaur-tabs-mode t)
  		:bind
  		("C-<prior>" . centaur-tabs-backward)
  		("C-<next>" . centaur-tabs-forward))

;; Graphics
     
	;; Disable stuff
	(setq inhibit-startup-message t)
	(menu-bar-mode -1)
	(scroll-bar-mode -1)
	(tool-bar-mode -1)

	;; Enable stuff
	(global-hl-line-mode t)

	;; Theme
	(use-package doom-themes
	  	:config
		(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
  	      	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  		(load-theme 'doom-laserwave t)

  		;; Enable flashing mode-line on errors
  		(doom-themes-visual-bell-config)
  
	       
  		;; Treemacs
  		(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  		(doom-themes-treemacs-config)
  	
		;; Corrects (and improves) org-mode's native fontification.
	  	(doom-themes-org-config))	
;; Behavior
	(global-set-key (kbd "TAB") 'self-insert-command);
	(setq tab-width 8)
	(defvaralias 'c-basic-offset 'tab-width)
    	(defvaralias 'cperl-indent-level 'tab-width)




;; Auto insert

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(centaur-tabs use-package undo-tree treemacs-projectile treemacs-persp treemacs-magit treemacs-icons-dired treemacs-evil selectrum)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
