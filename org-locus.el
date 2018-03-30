					; ======================== ORG-LOCUS ==========================
					; =============================================================


(require 'org)
(defcustom org-locus-note-directory nil
  "Directory where all the notes are stored.")

(defcustom org-locus-journal-directory nil
  "Directory where all the journal entries are stored.")

(defcustom org-locus-journal-file-ending "txt"
  "File ending for the Journal files. Default: txt")

(defun org-locus-new-note (name)
  "Create a new Note with the given name."
  (interactive "sName of the new note: ")
  (find-file (substitute-in-file-name (concat
				       org-locus-note-directory
				       "/"
				       (format-time-string "%Y%m%d%H%M-")
				       name
				       ".org"))))


;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun org-locus-rename-file-and-buffer (new-name)
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

(defun org-locus-rename-note (name)
  "Rename the open buffer and file but keep the ID at the beginning."
  (interactive "sNew name: ")
  (rename-file-and-buffer (concat
			   (first (split-string (buffer-name) "-"))
			   "-"
			   name
			   ".org")))

(defun org-locus-journal-entry (date)
  "Open Journal Entry for Entered day. Date Format 2017-01-31. If empty jump to Journal entry for today."
  (interactive "sDate: ")
  (find-file (substitute-in-file-name (concat
				       org-locus-journal-directory
				       "/"
				       (if (= (length date) 0)
					   (format-time-string "%Y-%m-%d")
					 date)
				       "."
				       org-locus-journal-file-ending))))

(defun org-locus-open-file-by-id (id)
  "Open the file in Note or File with the given ID. If the ID is not unique, the first found file is opened. Requirement: be in Note directory."
  (interactive "sID: ")
  (find-file (org-locus-id-to-path id)))


					; ========= ORG-LINK DEFINITIONS

(org-link-set-parameters "note"
 :follow 'org-locus-open-file-by-id
 :face '(:foreground "red" :underline t)
 :help-echo 'org-locus-filename-tooltip
 :complete (lambda () (org-locus-link-complete "note")))

(org-link-set-parameters "parent"
 :follow 'org-locus-open-file-by-id
 :face '(:foreground "red" :underline t)
 :help-echo 'org-locus-filename-tooltip
 :complete (lambda () (org-locus-link-complete "parent")))

(org-link-set-parameters "child"
 :follow 'org-locus-open-file-by-id
 :face '(:foreground "red" :underline t)
 :help-echo 'org-locus-filename-tooltip
 :complete (lambda () (org-locus-link-complete "child")))

(defun org-locus-filename-tooltip (window object position)
  "Returns the full filename of the Link ID at pointer as string."
  (save-excursion
    (goto-char position)
    (message
     (org-locus-id-to-path (org-element-property :path (org-element-context))))))

(defun org-locus-id-to-path (id)
  "Returns the full path for a note given it's ID."
  (first (file-name-all-completions id ".")))

(defun org-locus-link-complete (link)
  (concat link
	  ":"
	  (first (split-string (first (last (split-string
					     (read-file-name "Choose file to link: ")
					     "/")))
			       "-"))))

(defun org-locus-insert-backlink ()
  "Insert backlink for Node: Parent: or Child: Link."
  (interactive)
  (message "%s" (thing-at-point 'line)))
;; org-element-context
