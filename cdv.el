;;; init.el --- Milkmacs configuration file

;; Turn off mouse interface early in startup to avoid momentary display
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please... jeez
(setq inhibit-startup-screen t)

;;;; package.el
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (add-to-list 'package-archives '("melpa-local" . "/Users/dcurtis/src/melpa/packages/") t)
(package-initialize)

(defun mp-install-rad-packages ()
  "Install only the sweetest of packages."
  (interactive)
  (package-refresh-contents)
  (mapc '(lambda (package)
           (unless (package-installed-p package)
             (package-install package)))
        '(browse-kill-ring
          ido-ubiquitous
		  color-theme-solarized
          magit
          paredit
          smex
          undo-tree)))

;;;; macros
(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))

;;;; global key bindings


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
(scroll-bar-mode nil)	; I hate the damn scroll bar!
(tool-bar-mode -1)
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


;; (setq auto-mode-alist
;;       (append
;;        '(("\\.C$"    . c++-mode)
;; 	 ("\\.H$"    . c++-mode)
;; 	 ("\\.cc$"   . c++-mode)
;; 	 ("\\.hh$"   . c++-mode)
;; 	 ("\\.idl$"  . c++-mode)	 
;; 	 ("\\.c$"    . c-mode)
;; 	 ("\\.h$"    . c-mode)
;; 	 ("\\.m$"    . objc-mode)
;; 	 ("\\.java$" . java-mode)
;; 	 ("\\.tar$"  . tar-mode)
;; 	 ("\\.cfg$"  . java-properties-generic-mode)
;; 	 ("\\.tra$"  . java-properties-generic-mode)	 	 
;; 	 ) auto-mode-alist))
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This a cute little feature; make your mouse pointer avoid 
;; your text cursor (only under windowing systems -- works w/win32)
;;
;; (if window-system
;;    (progn
;;      (require 'avoid)
;;      (mouse-avoidance-mode 'jump)))
;;;
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs appends this bozo stuff, so leave it at the bottom
;;;
(put 'eval-expression 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq default-tab-width 4)

(setq version-control t)
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


(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 120))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 55)
                             (frame-char-height)))))))

(set-frame-size-according-to-resolution)

(setq custom-safe-themes t)


(after 'solarized-theme-autoloads
  (load-theme 'solarized-dark))

(setq backup-directory-alist
	  `((".*" . ,"~/.emacs.d/auto-save-list/")))


;;;
;;; init.el ends here


