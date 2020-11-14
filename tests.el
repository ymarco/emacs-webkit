;;(setq debug-on-error t)
(add-to-list 'load-path (expand-file-name "~/git/emacs-webkit"))

(require 'webkit)
(require 'evil-collection-webkit)

(evil-collection-xwidget-setup)

(webkit-browse-url "http://xkcd.com" t)
(setq webkit-search-prefix "https://google.com/search?q=")
(setq webkit-own-window t)

;;(setq my-pipe (get-buffer-process (cdr (car webkit--id-buffer-alist))))
(with-current-buffer (car webkit--buffers) (buffer-string))
(setq webkit--id (with-current-buffer (car webkit--buffers) webkit--id))

(webkit--execute-js webkit--id "alert(\"hi\")")
(webkit--execute-js webkit--id "\"hi\"" "message")
(webkit--add-user-script webkit--id "alert(\"hi\")")
(webkit--remove-all-user-scripts webkit--id)
(webkit--register-script-message webkit--id "message")
(webkit--unregister-script-message webkit--id "message")

;(webkit--register-script-message webkit--id "webkit--callback-key-down")

(webkit--execute-js webkit--id
                       "window.webkit.messageHandlers.message.postMessage(\"hi\")")

(webkit--execute-js webkit--id
                       "window.webkit.messageHandlers[\"webkit--callback-key-down\"].postMessage(\"hi\")"
                       "message")
(setq webkit--id nil)
(garbage-collect)

(defun webkit--echo-uri (uri)
  (message uri))

(defun webkit--echo-progress (progress)
  (message "%s%%" progress))

(add-hook 'webkit-uri-changed-functions 'webkit--echo-uri)
(add-hook 'webkit-progress-changed-functions 'webkit--echo-progress)
(setq webkit-uri-changed-functions nil)
(setq webkit-progress-changed-functions nil)

(remove-hook 'window-size-change-functions #'webkit--adjust-size)
(webkit--show webkit--id)

(webkit--resize webkit--id 50 50 200 400)


(ivy-read "read me" (list "a" "b" "c" "d")
          :initial-input "default"
          :action (lambda (v)
                    (setq result (if (consp v) (cdr v) v))))

(completing-read "prompt" (list (list "c" 1) (list "b" 2) (list "a" 3) (list "d" 4)))
