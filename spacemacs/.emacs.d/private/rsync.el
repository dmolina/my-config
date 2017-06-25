(defun tmtxt/dired-rsync (dest)
  (interactive
   ;; offer dwim target as the suggestion
   (list (expand-file-name (read-file-name "Rsync to:" (dired-dwim-target-directory)))))
  ;; store all selected files into "files" list
  (let ((files (dired-get-marked-files nil current-prefix-arg)))
    ;; the rsync command
    (setq tmtxt/rsync-command "rsync -arvz --progress ")
    ;; add all selected file names as arguments to the rsync command
    (dolist (file files)
      (setq tmtxt/rsync-command
            (concat tmtxt/rsync-command
                    (shell-quote-argument file)
                    " ")))
    ;; append the destination
    (setq tmtxt/rsync-command
          (concat tmtxt/rsync-command
                  (shell-quote-argument dest)))
    ;; run the async shell command
    (async-shell-command tmtxt/rsync-command "*rsync*")
    ;; finally, switch to that window
    (other-window 1)))
;;; bind it to C-c C-r
(define-key dired-mode-map (kbd "C-c C-r") 'tmtxt/dired-rsync)
