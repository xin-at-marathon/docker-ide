;https://acl.readthedocs.io/en/latest/index.html
(setenv "LANG" "en_US.UTF-8")
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode 1)

(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq-default tab-width 4)

(require 'package)
(setq package-check-signature nil)
(setq package-archives
      '(("marmalade"   . "http://marmalade-repo.org/packages/")
        ("gnu"         . "http://elpa.gnu.org/packages/")
        ("org"         . "http://orgmode.org/elpa/")
        ("melpa"       . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; === CUSTOM CHECK FUNCTION ===
(defun ensure-package-installed (&rest packages)
    "Assure every package is installed, ask for installation if it’s not.
     Return a list of installed packages or nil for every skipped package."
       (mapcar
	    (lambda (package)
	           (unless (package-installed-p package)
		            (package-install package)))
	         packages)
       )

;; === List my packages ===
;; simply add package names to the list
(ensure-package-installed
   'better-defaults
   'material-theme
   'auto-complete
   'prettier-js
   'cnfonts
   'dumb-jump
   'flycheck
   'drag-stuff
   'mmm-mode
   'js2-mode
   'yaml-mode
   'web-mode
   'vue-mode
   'vue-html-mode
   'json-mode
   'plantuml-mode
   'markdown-mode
   'reformatter
   'elpy
   'python-black
   ;; ... etc
)

(setq inhibit-startup-message t)
(global-linum-mode t)

(global-set-key (kbd "M-o") (lambda () (interactive)(previous-line)(end-of-line)(newline-and-indent)))
(global-set-key (kbd "C-o") (lambda () (interactive)(end-of-line)(newline-and-indent)))

(delete-selection-mode 1)

;;copy/cut to system clipboard 
;;(setq x-select-enable-clipboard t)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq outline-minor-mode-prefix "\C-c\C-o")
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)

;;(add-to-list 'exec-path "/usr/local/bin")
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(setq
   backup-by-copying t      ; don't clobber symlinks
    backup-directory-alist
     '(("." . "~/.saves/"))    ; don't litter my fs tree
      delete-old-versions t
       kept-new-versions 6
        kept-old-versions 2
	 version-control t)       ; use versioned backups

(require 'dired-x)
;;(setq dired-omit-files "^\\...+$")
;;(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))

(setq backup-directory-alist
            `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
            `((".*" ,temporary-file-directory t)))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(menu-bar-mode -1)
(tooltip-mode -1)
(tooltip-mode -1)
;;(scroll-bar-mode 1)

(toggle-frame-maximized)

;;font
(require 'cnfonts)
;; 让 cnfonts 随着 Emacs 自动生效。
(cnfonts-enable)
;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
(cnfonts-set-spacemacs-fallback-fonts)

;;(set-default-font "DejaVu Sans Mono-13")
;;(set-default-font "Source Code Pro 20")
;;(set-frame-font "DejaVu Sans Mono-13")
;;(set-fontset-font "fontset-default" '(#x0000 . #xFFFFF) '("DejaVu Sans Mono" . "unicode-bmp"))

;; set a default font
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

;; specify font for all unicode characters
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

;; specify font for chinese characters using default chinese font on linux
(when (member "WenQuanYi Micro Hei" (font-family-list))
  (set-fontset-font t '(#x4e00 . #x9fff) "WenQuanYi Micro Hei" ))



;;prettier https://github.com/prettier/prettier-emacs
(require 'prettier-js)
(setq prettier-js-args (list 
			   "--config"  (concat (getenv "HOME") "/.prettierrc.yaml")
			   ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(package-selected-packages
   (quote
    (reformatter python-black dart-mode dumb-jump prettier-js vue-mode vue-html-mode eslint-fix exec-path-from-shell web-mode js2-mode flycheck ansible yaml-mode drag-stuff cnfonts json-mode auto-complete w3m clang-format format-all java-imports dired-recent dired-quick-sort ggtags magit org plantuml-mode markdown-mode+ markdown-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(dolist (hook '(js-mode-hook vue-mode-hook vue-html-mode-hook java-mode-hook json-mode-hook yaml-mode-hook))
    (add-hook hook (lambda () (prettier-js-mode 1))))
;;(add-hook 'find-file-hook (lambda ()(format-all-mode)))

(add-hook 'find-file-hook (lambda ()(flyspell-mode)))

(add-hook 'java-mode-hook 'java-imports-scan-file)

(elpy-enable)
(dolist (hook '(python-mode-hook))
    (add-hook hook (lambda () (python-black-on-save-mode 1))))

(dolist (hook '(text-mode-hook))
    (add-hook hook (lambda () (flyspell-mode 1))))

(dolist (hook '(text-mode-hook))
    (add-hook hook (lambda () (auto-complete-mode 1))))

(ac-config-default)
(global-auto-complete-mode t)

(defun move-line-up ()
    "Move up the current line."
      (interactive)
        (transpose-lines 1)
	  (forward-line -2)
	    (indent-according-to-mode))

(defun move-line-down ()
    "Move down the current line."
      (interactive)
        (forward-line 1)
	  (transpose-lines 1)
	    (forward-line -1)
	      (indent-according-to-mode))

(global-set-key (kbd "C-M-p")  'move-line-up)
(global-set-key (kbd "C-M-n")  'move-line-down)

(recentf-mode 1)
(global-set-key "\C-x\C-r" 'recentf-open-files)
(global-set-key (kbd "C-x ,") 'beginning-of-buffer)
(global-set-key (kbd "C-x .") 'end-of-buffer)

(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 100)

;;robot-mode
;;(load-file "~/.emacs.d/robot-mode/robot-mode.el")
;;(add-to-list 'auto-mode-alist '("\\.robot\\'" . robot-mode))

;; enable drag-stuff on all buffer
(drag-stuff-global-mode)

;;copying lines without selecting them
;; http://emacs-fu.blogspot.com/2009/11/copying-lines-without-selecting-them.html
;; https://emacs.stackexchange.com/questions/2347/kill-or-copy-current-line-with-minimal-keystrokes
(defadvice kill-ring-save (before slick-copy activate compile) "When called
  interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end)) (message
  "Copied line") (list (line-beginning-position) (line-beginning-position
  2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
    (if mark-active (list (region-beginning) (region-end))
      (list (line-beginning-position)
        (line-beginning-position 2)))))

;;system specific initilization
(defmacro with-system (type &rest body)
    "Evaluate BODY if `system-type' equals TYPE."
      (declare (indent defun))
        `(when (eq system-type ',type)
	        ,@body))


(with-system darwin
	         (message "Enable copy & paste in OS X.")
		     (defun copy-from-osx ()
		             "Use OSX clipboard to paste."
			           (shell-command-to-string "pbpaste"))
		         
		         (defun paste-to-osx (text &optional push)
			         "Add kill ring entries (TEXT) to OSX clipboard.  PUSH."
				       (let ((process-connection-type nil))
					         (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
						             (process-send-string proc text)
							               (process-send-eof proc))))

			     (setq interprogram-cut-function 'paste-to-osx)
			         (setq interprogram-paste-function 'copy-from-osx)
				 )


(load-theme 'material t)

(dired "~")
