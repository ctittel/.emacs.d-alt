					;============ Meine emacs Init ==================
					;------------ Benötigte Packages
					;-------------------------------
					;- org-ref



					;---------------------- Paktearchive
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

(package-initialize)


					;------------------------------ keine Ahnung
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (solidity-mode org-ref))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))


					;--------------------------- Lade nicht vorhandene packages
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)



					;----------------------------- Backup Dateien
(setq
 backup-by-copying t      ; don't clobber symlinks
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t       ; use versioned backups
 )

					;------------------------ Startup Screen
(setq inhibit-startup-screen t)

					;--------------------------- Lade Theme
(load-theme 'wombat t)

					;============================================ ORG-MODE
					;--------------------------------- org-agenda
(setq org-agenda-files '("C:/Users/User/Google Drive/Notes/"))

					;-------------------------------- org babel (hier python)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . nil)
   (python . t)))

					;--------------------------- Tastenkombinationen
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(require 'org-ref)
(global-set-key (kbd "C-c l") 'org-store-link)

					;------------------------------Latex Export Klassen
(with-eval-after-load "ox-latex"
  (add-to-list 'org-latex-classes
               '("koma-article" "\\documentclass{scrartcl}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  '("book" "\\documentclass{book}"
    ("\\part{%s}" . "\\part*{%s}")
    ("\\chapter{%s}" . "\\chapter*{%s}")
    ("\\section{%s}" . "\\section*{%s}")
    ("\\subsection{%s}" . "\\subsection*{%s}")
    ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
  )

