(use-package smtpmail
   :config
; smtp
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-default-smtp-server "mail.gmail.com"
      smtpmail-smtp-server "mail.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-debug-info t)
)

(setq mu4e-sent-messages-behavior (lambda ()
                                    (if (string= (message-sendmail-envelope-from) "danimolina@gmail.com")
                                        'delete
                                      'sent)))


(use-package mu4e
  :init
(setq mu4e-maildir (expand-file-name "~/Mail/"))
(setq message-signature-file "~/.emacs.d/.signature") ; put your signature in this file
;  :defer t
                                        ; get mail
:config
(setq mu4e-account-alist
      '(("gmail"
         ;; Under each account, set the account-specific variables you want.
         (mu4e-sent-messages-behavior delete)
         (mu4e-sent-folder "/gmail/sent-mail")
         (mu4e-drafts-folder "/gmail/draft")
         (mu4e-trash-folder "/uca/trash")
         (user-mail-address "danimolina@gmail.com")
         (user-full-name "Daniel Molina"))
        ("uca"
         (mu4e-sent-messages-behavior sent)
         (mu4e-sent-folder "/uca/Sent")
         (mu4e-drafts-folder "/uca/Drafts")
         (mu4e-trash-folder "/uca/Trash")
         (user-mail-address "daniel.molina@uca.es")
         (user-full-name "Daniel Molina Cabrera"))))
(mu4e/mail-account-reset)
(setq ;mu4e-get-mail-command "mbsync -qHL gmail"
;      mu4e-html2text-command "w3m -T text/html"
     mu4e-update-interval 300
      mu4e-headers-auto-update t
      mu4e-compose-signature-auto-include nil
      mu4e-maildir "~/Mail/")

(setq mu4e-maildir-shortcuts
      '( ("/uca/Inbox"               . ?i)
         ("/uca/sent-mail"   . ?s)
         ("/uca/trash"       . ?t)
         ("/uca/drafts"    . ?d)))

;; show images
(setq mu4e-show-images t)


;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; general emacs mail settings; used when composing e-mail
;; the non-mu4e-* stuff is inherited from emacs/message-mode
(setq mu4e-reply-to-address "daniel.molina@uca.es"
    user-mail-address "daniel.molina@uca.es"
    user-full-name  "Daniel Molina")

;; spell check
(add-hook 'mu4e-compose-mode-hook
        (defun my-do-compose-stuff ()
           "My settings for message composition."
           (set-fill-column 72)
           (flyspell-mode)
	   (ispell-change-dictionary "castellano8")
	   ))

;; tell message-mode how to send mail
(setq message-send-mail-function 'smtpmail-send-it)
;; if our mail server lives at smtp.example.org; if you have a local
;; mail-server, simply use 'localhost' here.
(setq smtpmail-smtp-server "smtp.gmail.com")

(setq
mu4e-drafts-folder "/uca/Drafts"
mu4e-sent-folder   "/uca/Sent"
mu4e-trash-folder  "/uca/Trash")


;; a  list of user's e-mail addresses
(setq mu4e-user-mail-address-list '("daniel.molina@uca.es" "danimolina@gmail.com" "dmolina@decsai.ugr.es"))

;; ;; general emacs mail settings; used when composing e-mail
;; ;; the non-mu4e-* stuff is inherited from emacs/message-mode
;; (setq mu4e-reply-to-address "daniel.molina@uca.es"
;;       user-mail-address "daniel.molina@uca.es"
;;       user-full-name  "Daniel Molina")

(setq mu4e-reply-to-address "dmolina@decsai.ugr.es"
user-mail-address "dmolina@decsai.ugr.es"
user-full-name  "Daniel Molina")
; Store all documents in Descargas
(setq mu4e-attachment-dir  "~/Descargas")
;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "'mbsync -qa'")
(setq mu4e-compose-signature-auto-include nil)
;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))
;; Try to display images in mu4e
(setq
 mu4e-view-show-images t
 mu4e-view-image-max-width 800)
(setq mu4e-confirm-quit nil
      mu4e-headers-date-format "%d/%b/%Y %H:%M" ; date format
      mu4e-html2text-command "html2text -utf8 -width 72"
      )
; Show better the html links
(require 'mu4e-contrib)
(setq mu4e-html2text-command 'mu4e-shr2text)
(add-hook 'mu4e-view-mode-hook
  (lambda()
    ;; try to emulate some of the eww key-bindings
    (local-set-key (kbd "<tab>") 'shr-next-link)
    (local-set-key (kbd "<backtab>") 'shr-previous-link)))
(setq shr-color-visible-luminance-min 80)


;; sending mail
(setq message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "/usr/bin/msmtp"
      user-full-name "Daniel Molina Cabrera")
;; Borrowed from http://ionrock.org/emacs-email-and-mu.html
;; Choose account label to feed msmtp -a option based on From header
;; in Message buffer; This function must be added to
;; message-send-mail-hook for on-the-fly change of From address before
;; sending message since message-send-mail-hook is processed right
;; before sending message.
(defun choose-msmtp-account ()
  (if (message-mail-p)
      (save-excursion
        (let*
            ((from (save-restriction
                     (message-narrow-to-headers)
                     (message-fetch-field "from")))
             (account
              (cond
               ((string-match "danimolina@gmail.com" from) "gmail")
               ((string-match "daniel.molina@uca.es" from) "uca")
               ((string-match "dmolina@decsai.ugr.es" from) "decsai")
	       )))
          (setq message-sendmail-extra-arguments (list '"-a" account))))))

(setq message-sendmail-envelope-from 'header)
(add-hook 'message-send-mail-hook 'choose-msmtp-account)

;; ; Context
;; ; En http://pastie.org/10787847
;; (setq mu4e-contexts
;; 	`( ,
;; (make-mu4e-context :name "uca"
;; :enter-func (lambda () (mu4e-message "Switch to the uca context")
;; (setq mu4e-maildir-shortcuts 
;; '( ("/uca/INBOX"               . ?i)
;; ("/uca/Sent"   . ?s)
;; ("/uca/Trash"       . ?t)
;; ("/uca/Drafts"    . ?d)
;; )))
;; ;; leave-func not defined
;; :match-func (lambda (msg)
;; (when msg 
;; (mu4e-message-contact-field-matches msg 
;; :to "daniel.molina@uca.es")))
;; :vars '(
;; ( user-mail-address	     . "daniel.molina@uca.es"  )
;; ( user-full-name	    . "Daniel Molina Cabrera"  )
;; (mu4e-reply-to-address . "daniel.molina@uca.es")
;; (mu4e-compose-signature-auto-include t)
;; (mu4e-drafts-folder . "/uca/Drafts")
;; (mu4e-sent-folder   . "/uca/Sent")
;; (mu4e-trash-folder  ."/uca/Trash"))
;; ),(make-mu4e-context :name "gmail"
;; :enter-func (lambda () (mu4e-message "Switch to the gmail context")
;; (setq mu4e-maildir-shortcuts 
;; '( ("/gmail/Inbox"               . ?i)
;; ("/gmail/sent-mail"   . ?s)
;; ("/gmail/trash"       . ?t)
;; ("/gmail/drafts"    . ?d)
;; )))
;; ;; leave-func not defined
;; :match-func (lambda (msg)
;; (when msg 
;; (mu4e-message-contact-field-matches msg 
;; :to "danimolina@gmail.com")))
;; :vars '(
;; ( user-mail-address	     . "danimolina@gmail.com"  )
;; ( user-full-name	    . "Daniel Molina" )
;; (mu4e-compose-signature-auto-include nil)
;; (mu4e-reply-to-address . "danimolina@gmail.com")
;; (mu4e-drafts-folder . "/gmail/drafts")
;; ; don't save messages to Sent Messages, Gmail/IMAP takes care of this
;; ;(mu4e-sent-messages-behavior . 'delete)
;; (mu4e-trash-folder  ."/gmail/trash")
;; )
;; ),(make-mu4e-context :name "decsai"
;; :enter-func (lambda () (mu4e-message "Switch to the decsai context")
;; (setq mu4e-maildir-shortcuts 
;; '( ("/decsai/INBOX"               . ?i)
;; ("/decsai/Sent"   . ?s)
;; ("/decsai/Trash"       . ?t)
;; ("/decsai/Drafts"    . ?d)
;; )))

;; leave-func not defined
;; :match-func (lambda (msg)
;; (when msg 
;; (mu4e-message-contact-field-matches msg 
;; :to "dmolina@decsai.ugr.es")))
;; :vars '(
;; ( user-mail-address	     . "dmolina@decsai.ugr.es"  )
;; ( user-full-name	    . "Daniel Molina Cabrera" )
;; (mu4e-reply-to-address . "dmolina@decsai.ugr.es")
;; (mu4e-compose-signature-auto-include nil)
;; (mu4e-drafts-folder . "/decsai/Drafts")
;; (mu4e-sent-folder   . "/decsai/Sent")
;; (mu4e-trash-folder  ."/decsai/Trash"))
;; )


;; start with the first (default) context; 
;; default is to ask-if-none (ask when there's no context yet, and none match)
(setq mu4e-context-policy 'pick-first)


;; use this to sync with mbsync
(setq mu4e-get-mail-command "mbsync all")

;;rename files when moving
;;NEEDED FOR MBSYNC
(setq mu4e-change-filenames-when-moving t)

;; compose with the current context is no context matches;
;; default is to ask 
'(setq mu4e-compose-context-policy nil)
;;store org-mode links to messages
(use-package org-mu4e
  :init
;;store link to message if in header view, not to header query
  (setq org-mu4e-link-query-in-headers-mode nil))

; Access to marked files in dired mode to attach
(require 'gnus-dired)
;; make the `gnus-dired-mail-buffers' function also work on
;; message-mode derived modes, such as mu4e-compose-mode
(defun gnus-dired-mail-buffers ()
  "Return a list of active message buffers."
  (let (buffers)
    (save-current-buffer
      (dolist (buffer (buffer-list t))
        (set-buffer buffer)
        (when (and (derived-mode-p 'message-mode)
                (null message-sent-message-via))
          (push (buffer-name buffer) buffers))))
    (nreverse buffers)))

(setq gnus-dired-mail-mode 'mu4e-user-agent)
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

; Put mu4 as the default mail program
(setq mail-user-agent 'mu4e-user-agent)
					; Reply only personal email

(setq mu4e-compose-complete-only-personal t)
(setq mu4e-headers-sort-direction 'ascending)


; (use-package notmuch)

