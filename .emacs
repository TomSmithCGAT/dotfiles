; add load path for my own modules
;(setq load-path (nconc '( "~/emacs/") load-path))


; Dont show the GNU splash screen
(setq inhibit-startup-message t)

; Make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;; Open unidentified files in text mode
(setq major-mode 'text-mode)

;; Bestämmer hut mycket emacs scrollar när man går utanför fönstret.
(setq scroll-step 1)

;; Windows-like selection, but don't replace marked text when writing
;; Doesn't work in xemacs
;;(pc-selection-mode)
;;(delete-selection-mode nil)

; Display time
(display-time)

;; Set extensions
(setq tex-dvi-view-command "xdvi")
(setq compile-command "make")

;; När man programmerar kan det ibland vara väldigt trevligt om Emacs
;; blinkar matchande parenteser även om de står långt ifrån varandra.
;; Det kan göra Emacs lite långsammare någon gång ibland, men det är
;; det värt.
(setq blink-matching-paren-distance nil)

;; turn of bell.
(setq visible-bell t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HTML/WWW related stuff ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HTML-HELPER-MODE stuff

(autoload 'html-helper-mode "html-helper-mode" "HTML editing mode" t)
(or (assoc "\\.html$" auto-mode-alist)
    (setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) 
                                auto-mode-alist)))


(add-hook 'html-helper-load-hook 
          '(lambda ()
             (load "hhm-netscape")
             (load "html-font")
;;             (turn-on-auto-fill)
;;             (turn-on-aao-mode)
	     ))


(set-input-mode t nil 'gazonk 7)

; (setq standard-display-european t)

(defun delete-to-beginning-of-line ()
  (interactive)
  (let ((p (point)))
    (beginning-of-line)
    (kill-region (point) p)))

(defun delete-whole-line ()
  (interactive)
  (beginning-of-line)
  (kill-line))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(font-lock-global-modes t)
 '(font-lock-maximum-decoration t)
 '(ps-number-of-columns 2)
 '(ps-paper-type (quote a4))
 '(ps-portrait-mode t)
 '(ps-print-header nil)
 '(send-mail-function nil)
 '(show-paren-mode t))
; '(font-lock-support-mode (quote lazy-lock-mode)))

; Enable syntax highlighting
; (toggle-global-lazy-font-lock-mode)
(toggle-truncate-lines)

; We want some stuff loaded by default
;; (require 'w3)

; Where to load GNUS etc from
  (setq load-path 
        (cons (expand-file-name "/usr/local/share/emacs/site-lisp/") load-path))
  (setq Info-default-directory-list 
        (cons "/usr/local/share/emacs/site-lisp/" Info-default-directory-list))

; enable line truncation
(setq truncate-lines 1)

; Select everything
(defun select-all ()
  (interactive)
  (set-mark (point-min))
  (goto-char (point-max)))

; Insert the date
(defun insert-date ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%a %b %e, %Y %l:%M %p")))

; Convert from DOS > UNIX
(defun dos-unix ()
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\r" nil t) (replace-match "")))

; Convert from UNIX > DOS
(defun unix-dos ()
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\n" nil t) (replace-match "\r\n")))

; Display full iso8859-1 character set
(set-input-mode t nil '8bit)
; (standard-display-european 1)

; (global-set-key "\C-?" 'delete-backward-char)
(global-set-key "\C-h" 'delete-backward-char)

;; use C-mode for swig interface definitions
(setq auto-mode-alist
      (cons '("\\.i" . c-mode) auto-mode-alist))

;----------------------------------------------
;; setup python support : for emacs-22 this conflicts, thus with
;; the built-in python support for emacs.

;;; Define a function to make it easier to check which version we're
;;; running.

(defun running-emacs-older (major minor)
  (or (< emacs-major-version major)
      (and (= emacs-major-version major)
           (< emacs-minor-version minor))))

(cond ((running-emacs-older 22 0)
       (setq auto-mode-alist
	     (cons '("\\.py$" . python-mode) auto-mode-alist))
       (setq interpreter-mode-alist
	     (cons '("python" . python-mode)
		   interpreter-mode-alist))

       (autoload 'python-mode "python-mode" "Python editing mode." t)

       ; python mode extension in order be able to supply command line arguments
       ; for script execution.
       (add-hook 'python-mode-hook
		 '(lambda ()
		    (define-key py-mode-map "\C-c\C-c" 'py-execute-prog)
		    (define-key py-mode-map "\C-c\C-g" 'py-call-pdb)
		    (define-key py-mode-map "\C-c\C-w" 'pychecker)))
       ))

;----------------------------------------------
; Tex-Mode
; (require 'tex-site)

;----------------------------------------------
; ESS-mode
;
; (load "/afs/bi/bioinfo/group/share/emacs/ess/lisp/ess-site")

;----------------------------------------------
; start server for using emacsclient
(server-start)

;----------------------------------------------
; C++ stuff
(add-hook 'c-mode-common-hook '(lambda ()
				 (c-set-style "GNU")
				 (c-toggle-auto-hungry-state 1)
				 (local-set-key "\C-m"
					       'newline-and-indent)
				 (local-set-key "\C-c\C-c"
						'compile)))

;----------------------------------------------x

; (require 'blogmax)

;; setup blogmax mode for .blog files
; (setq auto-mode-alist
;       (cons '("\\.blog$" . weblog-mode) auto-mode-alist))

;; Editing wiki pages
;(require 'simple-wiki)
;(require 'twiki-outline)
;(add-to-list 'auto-mode-alist '("wiki" . twiki-outline-mode))
;
;(add-hook 'html-helper-load-hook '(lambda () (require 'html-font)))
;
;(add-to-list 'auto-mode-alist '("wiki.anat.ox.ac.uk" . twiki-outline-mode))

;----------------------------------------------
(add-hook 'c-mode-common-hook '(lambda ()
				 (c-set-style "GNU")
				 (c-toggle-auto-hungry-state 1)
				 (local-set-key "\C-m"
						'newline-and-indent)
				 (local-set-key "\C-c\C-c"
						'compile)))

;----------------------------------------------
; Makefiles
(add-to-list 'auto-mode-alist '("Makefile" . makefile-mode))

; interface to subversion
;(require 'psvn)


; start ido mode - advanced buffer switching
(ido-mode t)

; show fill column indicator
;(add-hook 'after-change-major-mode-hook 'fci-mode)
;(fci-rule-column 79)

;-----------------------------------------------
;; Show current line and column number
(column-number-mode t)
(line-number-mode t)

;; Show parenthesis pairs - screws up XEmacs
(show-paren-mode t)

;; Always end a file with a newline
(setq require-final-newline t)

(global-font-lock-mode t)

(setq font-lock-maximum-decoration t)

(add-to-list 'auto-mode-alist '("\\.pyx\\'" . cython-mode))

(define-derived-mode cython-mode python-mode "Cython"
  (font-lock-add-keywords
   nil
   `((,(concat "\\<\\(NULL"
	       "\\|c\\(def\\|har\\|typedef\\)"
	       "\\|e\\(num\\|xtern\\)"
	       "\\|float"
	       "\\|in\\(clude\\|t\\)"
	       "\\|object\\|public\\|struct\\|type\\|union\\|void"
	       "\\)\\>")
      1 font-lock-keyword-face t))))

; load ergonomic keye bindings
; (load-file "~/emacs/ergonomic_keybinding_dvorak.el")

;; Keys definitions
; Set proper delete key
(global-set-key [delete] `backward-delete-char)
; hitting "PrtScrn" prints
(global-set-key [print] 'ps-print-buffer-with-faces)
; hitting "F8" browses the active URL
(global-set-key [f8] 'browse-url-at-point)
; hitting "F11" runs fetchmail
(global-set-key [f11] 'fetchmail) 
; hitting "F12" replaces the signature
(global-set-key [f12] 'replace-signature)

; Set up buffer cycling like in windows (Ctrl-tab)
(global-set-key [C-tab] `bs-cycle-next)

; goto line
(global-set-key "\M-g" 'goto-line) ;; Set M-g to goto-line

; rst file editing
;(require 'rst)

;(setq auto-mode-alist
;      (append '(("\\.rst$" . rst-mode)
;                ("\\.rest$" . rst-mode)) auto-mode-alist))

;; turn on auto-fill in rst-mode files
(add-hook 'rst-mode-hook 'turn-on-auto-fill)

; (require 'goto-last-change)
;
;; set goto last change to \C-x\C-\\
;;(global-set-key "\C-x\C-\\" 'goto-last-change)

(define-minor-mode sensitive-mode
  "For sensitive files like password lists.
It disables backup creation and auto saving.

With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode."
  ;; The initial value.
  nil
  ;; The indicator for the mode line.
  " Sensitive"
  ;; The minor mode bindings.
  nil
  (if (symbol-value sensitive-mode)
      (progn
	;; disable backups
	(set (make-local-variable 'backup-inhibited) t)
	;; disable auto-save
	(if auto-save-default
	        (auto-save-mode -1)))
    ;resort to default value of backup-inhibited
    (kill-local-variable 'backup-inhibited)
    ;resort to default auto save setting
    (if auto-save-default
	(auto-save-mode 1))))

;(setq auto-mode-alist
; (append '(("\\.rst$" . sensitive-mode))
;               auto-mode-alist))

;;---------------------------------------------------
;; editing for ini files
;(require 'any-ini-mode)
;(add-to-list 'auto-mode-alist '(".*\\.ini$" . any-ini-mode))
;; (add-to-list 'auto-mode-alist '(".*\\.conf$" . any-ini-mode))

;;---------------------------------------------------
;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
(defvar autosave-dir
 (concat "/home/FILESERVER5/proteomics/" (user-login-name) "/.emacs_autosaves/" (user-login-name) "/" ))

(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
   (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
    (expand-file-name
     (concat "#%" (buffer-name) "#")))))

;;---------------------------------------------------
;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "/home/FILESERVER5/proteomics/" (user-login-name) "/.emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

;;---------------------------------------------------
;; hideshow code folding
(load-library "hideshow")
    (global-set-key (kbd "C-+") 'hs-toggle-hiding)
    (global-set-key (kbd "C-\\") 'hs-toggle-selective-display)
    (global-set-key (kbd "<f5>") 'hs-hide-all)    
    (global-set-key (kbd "<f6>") 'hs-show-all)

(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(add-hook 'python-mode-hook     'hs-minor-mode)

;;---------------------------------------------------
;; Start flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;---------------------------------------------------
;; Package managers
(setq package-archives'
      (
       ("gnu" . "http://elpa.gnu.org/packages/")
       ("marmalade" . "http://marmalade-repo.org/packages/")
       ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

;;---------------------------------------------------
;; Pyflakes for python - add filter to ignore certain errors
;; and convert some errors to warnings.
;; see: http://people.cs.uct.ac.za/~ksmith/2011/better-python-flymake-integration-in-emacs.html
;(when (load "flymake" t)
;  (defun flymake-pychecker-init ()
;    (let* ((temp-file (flymake-init-create-temp-buffer-copy
;                       'flymake-create-temp-inplace))
;           (local-file (file-relative-name
;                        temp-file
;                        (file-name-directory buffer-file-name))))
;      (list "/home/FILESERVER5/proteomics/tss38/.emacs.d/pyflakespep8.py" (list local-file))))
;  (add-to-list 'flymake-allowed-file-name-masks
;               '("\\.py\\'" flymake-pychecker-init)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))

(provide 'emacs)
;;; .emacs ends here
