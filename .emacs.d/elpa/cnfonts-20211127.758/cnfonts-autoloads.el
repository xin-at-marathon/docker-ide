;;; cnfonts-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "cnfonts" "cnfonts.el" (0 0 0 0))
;;; Generated autoloads from cnfonts.el

(autoload 'cnfonts-set-font-with-saved-fontsize "cnfonts" "\
使用已经保存的字号设置字体.
如果 FRAME 是 non-nil, 设置对应的 FRAME 的字体。

\(fn &optional FRAME)" t nil)

(autoload 'cnfonts-reset-fontsize "cnfonts" "\
使用 `cnfonts-default-fontsize' 重置字号.

\(fn)" t nil)

(autoload 'cnfonts-decrease-fontsize "cnfonts" "\
Cnfonts 减小字体.

\(fn)" t nil)

(autoload 'cnfonts-increase-fontsize "cnfonts" "\
Cnfonts 增大字体.

\(fn)" t nil)

(autoload 'cnfonts-switch-profile "cnfonts" "\
切换 cnfonts profile.

\(fn)" t nil)

(autoload 'cnfonts-next-profile "cnfonts" "\
选择下一个字体设置 profile.

\(fn &optional _)" t nil)

(autoload 'cnfonts-edit-profile "cnfonts" "\
编辑当前 cnfonts profile.

\(fn)" t nil)

(autoload 'cnfonts-regenerate-profile "cnfonts" "\
重新生成当前 profile.

\(fn)" t nil)

(autoload 'cnfonts-enable "cnfonts" "\
运行这个函数，可以让 Emacs 启动的时候就激活 cnfonts.

\(fn)" t nil)

(autoload 'cnfonts-disable "cnfonts" "\
清除与 cnfonts 相关的 hook 设定.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cnfonts" '("cnfonts-")))

;;;***

;;;### (autoloads nil "cnfonts-ui" "cnfonts-ui.el" (0 0 0 0))
;;; Generated autoloads from cnfonts-ui.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cnfonts-ui" '("cnfonts-ui")))

;;;***

;;;### (autoloads nil nil ("cnfonts-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; cnfonts-autoloads.el ends here
