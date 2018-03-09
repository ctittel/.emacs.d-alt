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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes (quote (alect-black)))
 '(custom-safe-themes
   (quote
    ("5e3fc08bcadce4c6785fc49be686a4a82a356db569f55d411258984e952f194a" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "599f1561d84229e02807c952919cd9b0fbaa97ace123851df84806b067666332" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(fci-rule-color "#383838")
 '(gnus-logo-colors (quote ("#0d7b72" "#adadad")))
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")))
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(org-agenda-files
   (quote
    ("c:/Users/Christoph/Google Drive/Studium/Bachelorarbeit/Abstract_Bachelorarbeit/abstract.org" "C:\\Users\\Christoph\\Google Drive/Notizen/Org/todo.org")))
 '(package-selected-packages
   (quote
    (csv-mode alect-themes zenburn-theme w3 deft elpy plantuml-mode slime helm-bibtex langtool flycheck company helm org-ref)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(tool-bar-mode nil)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
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
					;-------------------- Menu Bar und Tool Bar
(menu-bar-mode -1)
(tool-bar-mode -1)

					;------------ bell
(setq visible-bell t)

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

					;----------- csv mode
(setq csv-separators (list "," "\t" ";"))

					;---------------- deft
(require 'deft)
(setq deft-extensions '("txt" "tex" "org"))
(setq deft-directory (substitute-in-file-name "$GoogleDrive/Privat/Notizen"))
(setq deft-recursive t)
(global-set-key [f8] 'deft)
;; (setq deft-use-filename-as-title t)
(setq deft-org-mode-title-prefix t)
(global-set-key (kbd "C-x C-g") 'deft-find-file)
(setq deft-new-file-format "%Y%m%d%H%M")
(setq deft-default-extension "org")
(setq deft-text-mode 'org-mode)
(setq deft-auto-save-interval nil)

					;============== ORG-MODE
					;------- org mode
(setq org-startup-folded nil)
(setq org-src-fontify-natively t)
(setq org-link-file-path-type 'relative)

					;------------ visual line mode
(add-hook 'org-mode-hook #'visual-line-mode)

					;------------- org agenda
(setq org-log-done 'time)
(setq org-agenda-files (list (substitute-in-file-name "$GoogleDrive/Privat/todo.org")))
(setq org-archive-location "archiv.org::datetree/")

					;----------------- latex export
(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))


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
(autoload 'helm-bibtex "helm-bibtex" "" t)

(setq bibtex-completion-bibliography (substitute-in-file-name "$GoogleDrive/Privat/Notizen/quellen.bib")
      bibtex-completion-library-path (substitute-in-file-name "$GoogleDrive/Privat/Quellen")
      bibtex-completion-notes-path (substitute-in-file-name "$GoogleDrive/Privat/Notizen"))


;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
	(start-process "open" "*open*" "open" fpath)))

;; alternative
;; (setq bibtex-completion-pdf-open-function 'org-open-file)

					;---------------------- org ref
(setq reftex-default-bibliography '((substitute-in-file-name "$GoogleDrive/Privat/quellen.bib")))

;; see org-ref for use of these variables
(setq  org-ref-default-bibliography (list (substitute-in-file-name "$GoogleDrive/Privat/Notizen/quellen.bib"))
       org-ref-pdf-directory (substitute-in-file-name "$GoogleDrive/Privat/Quellen/"))

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



					;===================== Eigene Funktionen
(defun new-note (name)
  "Erstellt eine neue Notiz."
  (interactive "sName of the new note: ")
  (find-file (substitute-in-file-name (concat
				       "$GoogleDrive/Privat/Notizen/"
				       (format-time-string "%Y%m%d%H%M-")
				       name
				       ".org"))))


;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun rename-note (name)
  "Geöffnete Notiz (mit 12-stelliger ID am Anfang) umbennenen."
  (interactive "sNew name: ")
  (rename-file-and-buffer (concat
			   (first (split-string (buffer-name) "-"))
			   "-"
			   name
			   ".org")))
  
  
