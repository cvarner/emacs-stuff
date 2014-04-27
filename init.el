;;todo
;; - I want certain files always in my 'recent' list
;; - git isn't working
;; - error msg, can't find mvn
;; - can't find grep
;; - make sure malabar is installed -- don't think libs are built


;;;;
;; package load stuff
;;;;
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))


(defadvice package-compute-transaction
  (before package-compute-transaction-reverse (package-list requirements) activate compile)
    "reverse the requirements"
    (setq requirements (reverse requirements))
    (print requirements))

;;;; package.el
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;;; macros
(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))

;;;; emacs lisp
(defun imenu-elisp-sections ()
  (setq imenu-prev-index-position-function nil)
  (add-to-list 'imenu-generic-expression '("Sections" "^;;;; \\(.+\\)$" 1) t))

(add-hook 'emacs-lisp-mode-hook 'imenu-elisp-sections)

;; cdv

;;(show-paren-mode -1)
(setq cursor-in-non-selected-windows nil)
(blink-cursor-mode -1)
(setq frame-title-format "%b")
(transient-mark-mode 1)
(global-set-key [mouse-3] 'imenu)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; The following should *always* be set -- especially for root. Failure to do
;;; so can really mess things up.

;; the 'backup-by-copying-' variable settings are necessary to preserve owner/
;; group on files AND (most importantly, and obscure) keep hardlinks pointing
;; correctly. See the documentation on the variable 'make-backup-files'
;;

(setq backup-by-copying t)
(setq backup-by-copying-when-linked t )

(setq require-final-newline 'ask) ;; If a file doesn't have a \n on the last line, ask if
                                  ;; one should be added; this is essential for editing
                                  ;; system files!!
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
(modify-syntax-entry ?_ "w")
(modify-syntax-entry ?- "w")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs appends this bozo stuff, so leave it at the bottom
;;;
(put 'eval-expression 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq default-tab-width 4)

(setq version-control t) ;; @@ revisit this -- there are new settings, don't know if I need this now
(setq kept-new-versions 1)
(setq kept-old-versions 1)
(setq delete-old-versions t)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [(control tab)] 'bury-buffer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  I set this so that if I create a file w/emacs under DOS, the
;;; end-of-line style will be good for Unix.
;; (prefer-coding-system 'raw-text-unix)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; I like to know where I am...
(line-number-mode 1)
(column-number-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(auto-compression-mode t)

(global-set-key "\C-m"     'newline-and-indent)
(global-set-key "\C-x\C-j" 'compile)
(global-set-key "\C-x\C-k" 'kill-buffer)
(global-set-key "\C-xk"    'kill-buffer)
(global-set-key "\M-g"     'goto-line)
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; uniquify makes better buffer names
;; @@ I think this is default behavour in v 24
(after 'uniquify
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-min-dir-content 2))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; personal settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; variables
(setq vc-mistrust-permissions t)

(setq search-highlight t)
(setq query-replace-highlight t)
(setq save-abbrevs t)

(setq default-major-mode 'fundamental-mode)
(setq default-truncate-lines nil)

(setq inhibit-startup-message t)

(setq Man-notify-method 'pushy)
(setq auto-save-list-file-prefix nil)

(after 'rainbow-delimiters-autoloads
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode-enable))


(defun cdv-dev-stuff ()
  (require 'cedet)
  (require 'semantic)
  (load "semantic/loaddefs.el")
  (semantic-mode 1);;
  (require 'malabar-mode)
  (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))      

  (setq malabar-groovy-lib-dir "~/src/malabar-mode/target/lib")
  (setq malabar-groovy-extra-classpath '("~/src/malabar-mode/target/classes"))
  (add-to-list 'load-path "~/src/malabar-mode/src/main/lisp/")
  ;;
  ;; eclim
  ;;
  (require 'eclim)
  (global-eclim-mode)
  (require 'eclimd)

  (setq help-at-pt-display-when-idle t)
  (setq help-at-pt-timer-delay 0.1)
  (help-at-pt-set-timer)

  ;; add the emacs-eclim source
  (require 'ac-emacs-eclim-source)
  (ac-emacs-eclim-config)

  (require 'company)
  (require 'company-emacs-eclim)
  (company-emacs-eclim-setup)
  (global-company-mode t))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'prog-mode-hook 'cdv-dev-stuff)

(setq custom-safe-themes t)

(after 'solarized-theme-autoloads
  (load-theme 'solarized-dark))

(setq backup-directory-alist
	  `((".*" . ,"~/.auto-save-list/")))

;;;;;;
;;
;; Or enable more if you wish
;;
;;; CEDET

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-term-color-vector [unspecified "#1F1611" "#660000" "#144212" "#EFC232" "#5798AE" "#BE73FD" "#93C1BC" "#E6E1DC"])
 '(background-color "#fdf6e3")
 '(background-mode light)
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(cursor-color "#657b83")
 '(custom-enabled-themes (quote (tango-dark)))
 '(cygwin-mount-cygwin-bin-directory "C:\\cygwin64\\bin")
 '(eclim-eclipse-dirs (quote ("/cygdrive/c/eclipse" "/usr/lib/eclipse" "/usr/local/lib/eclipse" "/usr/share/eclipse")))
 '(eclim-executable "/cygdrive/c/eclipse/eclim.bat ")
 '(fci-rule-character-color "#452E2E")
 '(fci-rule-color "#452E2E")
 '(foreground-color "#657b83")
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "outline" :slant normal :weight normal :height 143 :width normal)))))


(if window-system
	(progn
	  (if (eq system-type 'windows-nt)
		  (progn
			(setq default-directory "~/")
			(w32-send-sys-command #xf030) ;; set window to full screen
			(add-hook 'window-setup-hook (lambda () (tool-bar-mode -1)))

            ;;;; cygwin support
			;; Sets your shell to use cygwin's bash, if Emacs finds it's running
			;; under Windows and c:\cygwin exists. Assumes that C:\cygwin\bin is
			;; not already in your Windows Path (it generally should not be).
			;;
			(if (file-accessible-directory-p "C:\cygwin")
				(setq cygwin-dir "C:\cygwin")
			  (if (file-accessible-directory-p "C:\cygwin64")
				  (setq cygwin-dir "C:\cygwin64")))

			(let* ((cygwin-root cygwin-dir)
				   (cygwin-bin (concat cygwin-root "/bin")))
			  (when (and (eq 'windows-nt system-type)
						 (file-readable-p cygwin-root))
				
				(setq exec-path (cons cygwin-bin exec-path))
				(setenv "PATH" (concat cygwin-bin ";" (getenv "PATH")))
				
				;; By default use the Windows HOME.
				;; Otherwise, uncomment below to set a HOME
				;;      (setenv "HOME" (concat cygwin-root "/home/eric"))
				
				;; NT-emacs assumes a Windows shell. Change to bash.
				(setq shell-file-name "bash")
				(setenv "SHELL" shell-file-name) 
				(setq explicit-shell-file-name shell-file-name) 
				
				;; This removes unsightly ^M characters that would otherwise
				;; appear in the output of java applications.
				(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
				(require 'cygwin-mount)
				(cygwin-mount-activate)))))))

;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)


;; (custom-set-variables
;;  '(eclim-eclipse-dirs (quote ("c:/eclipse")))
;;  '(eclim-executable "c:/eclipse/eclim.bat"))
 ;; '(eclimd-executable "c:/apps/x64/dev/ide/eclipse/jee-4.2.1/eclimd.bat")
 ;; '(eclimd-default-workspace "c:/ws/"))

;; (custom-set-variables
;;  '(eclim-eclipse-dirs (quote ("c:/apps/x64/dev/ide/eclipse/jee-4.2.1/")))
;;  '(eclim-executable "c:/apps/x64/dev/ide/eclipse/jee-4.2.1/eclim.bat")
;;  '(eclimd-executable "c:/apps/x64/dev/ide/eclipse/jee-4.2.1/eclimd.bat")
;;  '(eclimd-default-workspace "c:/ws/"))

(require 'iedit)
(require 'auto-complete)
(require 'auto-complete-config)
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; yasnippet stuff
;;;;
(require 'yasnippet)
(yas-global-mode 1)

;; (ac-config-default)
(defun check-expansion ()
  (save-excursion
	(if (looking-at "\\_>") t
	  (backward-char 1)
	  (if (looking-at "\\.") t
		(backward-char 1)
		(if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
	(yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
	  (minibuffer-complete)
	(if (or (not yas/minor-mode)
			(null (do-yas-expand)))
		(if (check-expansion)
			(company-complete-common)
		  (indent-for-tab-command)))))

(global-set-key [tab] 'tab-indent-or-complete)
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'magit)
(require 'winner
  :config (winner-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  toggles between horizontal and vertical layout of two windows.
;;
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Store frequently used files in registers.
;; Jump to register with: ctrl-x r j
(dolist
    (r `((?i (file . "~/.emacs.d/init.el"))
         (?e (file . "~/.emacs.d"))
         ))
  (set-register (car r) (cadr r)))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-j")
				(lambda ()
				  (interactive)
				  (join-line -1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; "If you enable Delete Selection mode, a minor mode, then inserting text
;;  while the mark is active causes the selected text to be deleted first."
;;
(delete-selection-mode 1)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'erc)
;; (require 'easymenu)
;;     (easy-menu-add-item  nil '("tools")
;;       ["IRC with ERC" erc t])

;; (defun try-require (feature)
;;   (condition-case nil
;;       (require feature)
;;     (error (progn
;;              (message "could not require %s" feature)
;;              nil))))

;; (when (try-require 'recentf)
;;   (setq recentf-exclude '("~$"))
;;   (setq recentf-max-saved-items 99)


;; No splash screen please... jeez
(setq inhibit-startup-screen t)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
