					;============ Meine emacs Init ==================
					;------------ Benötigte Packages
					;-------------------------------


					;----------------- Paktearchive
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

(package-initialize)


					;----------------- vom System
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes nil)
 '(package-selected-packages
   (quote
    (deft elpy plantuml-mode slime helm-org-rifle helm-bibtex langtool flycheck company helm org-ref))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))


					;---------- Lade nicht vorhandene packages
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)



					;------------- Backup Dateien
(setq
 backup-by-copying t      ; don't clobber symlinks
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t       ; use versioned backups
 )
(setq auto-save-file-name-transforms `((".*" . ,temporary-file-directory)))
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

					;----------- Startup Screen
(setq inhibit-startup-screen t)

					;--------------- helm
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

					;(defun spacemacs//helm-hide-minibuffer-maybe ()
					; "Hide minibuffer in Helm session if we use the header line as input field."
					;(when (with-helm-buffer helm-echo-input-in-header-line)
					; (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
					;  (overlay-put ov 'window (selected-window))
					; (overlay-put ov 'face
					;             (let ((bg-color (face-background 'default nil)))
					;              `(:background ,bg-color :foreground ,bg-color)))
					;(setq-local cursor-type nil))))


					;(add-hook 'helm-minibuffer-set-up-hook
					;         'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

					;---------------- Company Mode
(add-hook 'after-init-hook 'global-company-mode)


					;----------------- Flycheck
(global-flycheck-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

					;----------------- Langtool
					;----------- languagetool benötigt
(require 'langtool)
;;(setq langtool-language-tool-jar "C:/ProgramData/chocolatey/lib/languagetool/tools/LanguageTool-3.9/languagetool-commandline.jar")
(setq langtool-language-tool-jar (substitute-in-file-name "$LanguageTool/languagetool-commandline.jar"))
(setq langtool-default-language "de-DE")
(setq langtool-mother-tongue "de"
      langtool-disabled-rules '("WHITESPACE_RULE"
                                "EN_UNPAIRED_BRACKETS"
                                "COMMA_PARENTHESIS_WHITESPACE"
                                "EN_QUOTES"))

					;------------------------ Lisp SLIME
(require 'slime-autoloads)
(require 'slime)
(setq inferior-lisp-program "sbcl")
;(slime-setup)
;(setq slime-auto-connect 'ask)
;(setq slime-contribs '(slime-fancy))
					;(add-to-list 'slime-contribs 'slime-repl)
(setf temporary-file-directory (substitute-in-file-name "$TEMP"))
;(setf (ext:getenv "temp") temporary-file-directory)
;(setf (ext:getenv "tmp") temporary-file-directory)

					;------------- Python
(elpy-enable)
(setq elpy-rpc-backend "jedi")

					;---------------- deft
(require 'deft)
(setq deft-extensions '("txt" "tex" "org"))
(setq deft-directory (substitute-in-file-name "$GoogleDrive"))
(setq deft-recursive t)
(global-set-key [f8] 'deft)
(setq deft-use-filename-as-title t)
(global-set-key (kbd "C-x C-g") 'deft-find-file)

					;============== ORG-MODE
					;----------------- latex export
(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))

					;----------------------- helm org rifle
(require 'helm-org-rifle)
(setq helm-org-rifle-show-path t)
					;----------- org babel (hier python)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . nil)
   (python . t)
   (plantuml . t)))

					;-------------- plantuml (umgehungsvariable plantuml)
(setq org-plantuml-jar-path
     (substitute-in-file-name "$plantuml/plantuml.jar"))


					;------------- helm bibtex
(setq bibtex-completion-bibliography (substitute-in-file-name "$GoogleDrive/Notizen/Org/quellen.bib")
      bibtex-completion-library-path (substitute-in-file-name "$GoogleDrive/Archiv/Dokumente/Quellen")
      bibtex-completion-notes-path (substitute-in-file-name "$GoogleDrive/Notizen/Org"))


;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
	(start-process "open" "*open*" "open" fpath)))

;; alternative
;; (setq bibtex-completion-pdf-open-function 'org-open-file)

					;---------------------- org ref
(setq reftex-default-bibliography '((substitute-in-file-name "$GoogleDrive/Notizen/Org/quellen.bib")))

;; see org-ref for use of these variables
(setq  org-ref-default-bibliography (list (substitute-in-file-name "$GoogleDrive/Notizen/Org/quellen.bib"))
       org-ref-pdf-directory (substitute-in-file-name "$GoogleDrive/Archiv/Dokumente/Quellen"))

;; Tell org-ref to let helm-bibtex find notes for it
(setq org-ref-notes-function
      (lambda (thekey)
	(let ((bibtex-completion-bibliography (org-ref-find-bibliography)))
	  (bibtex-completion-edit-notes
	   (list (car (org-ref-get-bibtex-key-and-file thekey)))))))

					;---------------- Tastenkombinationen
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(require 'org-ref)
(global-set-key (kbd "C-c l") 'org-store-link)

					;--------------- Latex Export Klassen
(with-eval-after-load "ox-latex"
  (add-to-list 'org-latex-classes
               '("koma-article" "\\documentclass{scrartcl}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

	       '("book" "\\documentclass{book}"
		 ("\\part{%s}" . "\\part*{%s}")
		 ("\\chapter{%s}" . "\\chapter*{%s}")
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		 ("\\paragraph{%s}" . "\\paragraph*{%s}")
		 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

	       ))


