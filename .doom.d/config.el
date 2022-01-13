(setq user-full-name "Simone Salzano"
      user-mail-address "salzanosimone99@gmail.com")
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(setq doom-theme 'doom-one)
(setq doom-font "FiraCode Nerd Font 11")
(setq display-line-numbers-type t)
(defvar fancy-splash-image-template
  (expand-file-name "~/.doom.d/logo.png" doom-private-dir)
  "Default template svg used for the splash image, with substitutions from ")
(setq org-directory "~/org/roam")
(setq org-hide-emphasis-markers t)
(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(add-hook 'org-mode-hook 'visual-line-mode)

(after! org
  (custom-set-faces!
    '(org-level-1 :height 1.15 :inherit outline-1)
    '(org-level-2 :height 1.13 :inherit outline-2)
    '(org-level-3 :height 1.11 :inherit outline-3)
    '(org-level-4 :height 1.09 :inherit outline-4)
    '(org-level-5 :height 1.07 :inherit outline-5)
    '(org-level-6 :height 1.05 :inherit outline-6)
    '(org-level-7 :height 1.03 :inherit outline-7)
    '(org-level-8 :height 1.01 :inherit outline-8)))

(after! org
  (custom-set-faces!
    '(org-document-title :height 1.50)))

(electric-indent-mode 0)

(setq org-startup-with-inline-images t)
(after! org(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5)))
(setq org-preview-latex-default-process 'dvisvgm)
(setq org-checkbox-hierarchical-statistics nil)
(use-package! org-roam
      :init
      (setq org-roam-v2-ack t)
      :custom
      (org-roam-directory (file-truename "/mnt/d/Documents/Notes"))
      (org-roam-completion-everywhere t)
      (org-roam-capture-templates
        '(("d" "default" plain "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+author: Simone Salzano\n#+date:%U\n")
           :unarrowed t))
        )
      (org-id-location-file (file-truename "/mnt/d/Documents/Notes/.orgids"))
      :bind (("C-c n l" . org-roam-buffer-toggle)
             ("C-c n f" . org-roam-node-find)
             ("C-c n g" . org-roam-graph)
             ("C-c n i" . org-roam-node-insert)
             ("C-c n c" . org-roam-capture)
             ;; Dailies
             ("C-c n j" . org-roam-dailies-capture-today))
      :config
      (org-roam-setup)
      (org-roam-update-org-id-locations)
      ;; If using org-roam-protocol
      (require 'org-roam-protocol))
(use-package! websocket
        :after org-roam)
(use-package! org-roam-ui
    :after org-roam
    :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t)

(setq org-roam-dailies-directory "/mnt/d/Documents/Notes/daily/")

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"

                            "#+title: %<%Y-%m-%d>\n#+AUTHOR: Simone Salzano\n")))))
(use-package! org-superstar
  :after org
  :hook (org-mode . org-superstar-mode )
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")
  (setq org-superstar-first-inlinetask-bullet "●")))
(require 'org-crypt)
(require 'epa-file)
(require 'latex-preview-pane)
(latex-preview-pane-enable)
(epa-file-enable)
(org-crypt-use-before-save-magic)
(after! org (setq org-startup-with-latex-preview t))
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
(setq org-crypt-key nil)
(setq org-latex-hyperref-template "\\hypersetup{\n pdfauthor={%a},\n pdftitle={%t},\n pdfkeywords={%k},\n pdfsubject={%d},\n pdfcreator={%c}, \n pdflang={%L}, \n colorlinks = true}\n")
(when (display-graphic-p)
  (require 'all-the-icons))

(add-hook 'treemacs-mode-hook (lambda () (load-theme 'doom-one t)))
(face-attribute 'default :background nil t)
(use-package! yasnippet
	      :config
	      (setq yas-snippet-dirs '("~/.doom.d/snippets"))
	      (yas-global-mode 1))
(setq ispell-dictionary "italiano")
