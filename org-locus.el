					; ======================== ORG-LOCUS ==========================
					; =============================================================


(require 'org)

(defun ct-new-note (name)
  "Erstellt eine neue Notiz."
  (interactive "sName of the new note: ")
  (find-file (substitute-in-file-name (concat
				       "$Notizen/"
				       (format-time-string "%Y%m%d%H%M-")
				       name
				       ".org"))))


;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun ct-rename-file-and-buffer (new-name)
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

(defun ct-rename-note (name)
  "Geöffnete Notiz (mit 12-stelliger ID am Anfang) umbennenen."
  (interactive "sNew name: ")
  (rename-file-and-buffer (concat
			   (first (split-string (buffer-name) "-"))
			   "-"
			   name
			   ".org")))

(defun ct-journal-entry (date)
  "Open Journal Entry for Entered day. Date Format 2017-01-31. If empty jump to Journal entry for today."
  (interactive "sDate: ")
  (find-file (substitute-in-file-name (concat
				       "$Journal/"
				       (if (= (length date) 0)
					   (format-time-string "%Y-%m-%d")
					 date)
				       ".txt"))))

(defun ct-open-file-by-id (id)
  "Open the file in Notes with the given ID."
  (interactive "sID: ")
  (find-file (ct-id-to-path id)))


					;----------------------- My own Org Link Types
;; http://kitchingroup.cheme.cmu.edu/blog/2016/11/04/New-link-features-in-org-9/

;; Missing:
;; ========
;; - complete for node/parent/child:
;;         x  1. Open Minipuffer and get path
;;         x  2. Insert Link in current buffer to choosen file
;;           3. Insert Link to current buffer in choosen file (Backlink)

(org-link-set-parameters
 "node"
 :follow 'ct-open-file-by-id
 :face '(:foreground "red" :underline t)
 :help-echo (lambda () (ct-link-complete "node")))

(org-link-set-parameters
 "parent"
 :follow 'ct-open-file-by-id
 :face '(:foreground "red" :underline t)
 :help-echo (lambda () (ct-link-complete "parent")))

(org-link-set-parameters
 "child"
 :follow 'ct-open-file-by-id
 :face '(:foreground "red" :underline t)
 :help-echo 'ct-filename-tooltip
 :complete (lambda () (ct-link-complete "child")))

(defun ct-filename-tooltip (window object position)
  "Position is the position of something like file:2323. Returns a full (relative) filepath to this file."
    (save-excursion
    (goto-char position)
    (goto-char (org-element-property :begin (org-element-context)))
    (cond ((or (looking-at org-plain-link-re) (looking-at org-bracket-link-regexp))
           (format "OPEN FILE %s" (first (file-name-all-completions
					  (first (rest (split-string (match-string 0) "\\:")))
					  "."))))
          (t "No match"))))

(defun ct-id-to-path (id)
  "Give ID, returns filepath."
  (find-file (first (file-name-all-completions id "."))))

(defun ct-link-complete (link)
  (concat link
	  ":"
	  (first (split-string (first (last (split-string
					     (read-file-name "Choose file to link: ")
					     "/")))
			       "-"))))

(defun ct-insert-backlink ()
  "Insert backlink for Node: Parent: or Child: Link."
  (interactive)
  (message "%s" (thing-at-point 'line)))
