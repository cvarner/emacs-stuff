;;; emacs-eclim-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (eclim-mode eclim/workspace-dir) "eclim" "eclim.el"
;;;;;;  (21332 22731 0 0))
;;; Generated autoloads from eclim.el

(autoload 'eclim/workspace-dir "eclim" "\


\(fn)" nil nil)

(defvar eclim-mode-map (let ((map (make-sparse-keymap))) (define-key map (kbd "M-TAB") 'eclim-complete) map) "\
The keymap used in `eclim-mode'.")

(autoload 'eclim-mode "eclim" "\
An interface to the Eclipse IDE.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (eclim-manage-projects) "eclim-project" "eclim-project.el"
;;;;;;  (21332 22731 0 0))
;;; Generated autoloads from eclim-project.el

(autoload 'eclim-manage-projects "eclim-project" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("ac-emacs-eclim-source.el" "company-emacs-eclim.el"
;;;;;;  "eclim-ant.el" "eclim-completion.el" "eclim-java.el" "eclim-maven.el"
;;;;;;  "eclim-problems.el" "eclimd.el" "emacs-eclim-pkg.el") (21332
;;;;;;  22731 255000 0))

;;;***

(provide 'emacs-eclim-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; emacs-eclim-autoloads.el ends here
