(use-package smtpmail
  :config
                                        ; smtp
  (setq message-send-mail-function 'smtpmail-send-it
        smtpmail-default-smtp-server "mail.gmail.com"
        smtpmail-smtp-server "mail.gmail.com"
        smtpmail-smtp-service 587
        smtpmail-debug-info t)
)

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
  ;; show images
  (setq mu4e-show-images t)


  ;; use imagemagick, if available
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))
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

                                        ; Show better the html links
  (require 'mu4e-contrib)
  (setq mu4e-html2text-command 'mu4e-shr2text)
  (add-hook 'mu4e-view-mode-hook
            (lambda()
              ;; try to emulate some of the eww key-bindings
              (local-set-key (kbd "<tab>") 'shr-next-link)
              (local-set-key (kbd "<backtab>") 'shr-previous-link)))
  (setq shr-color-visible-luminance-min 80)
  (setq mu4e-headers-sort-direction 'ascending)

)
