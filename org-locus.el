					; ======================== ORG-LOCUS ==========================
					; =============================================================


(require 'org)
(defcustom org-locus-note-directory nil
  "Directory where all the notes are stored.")

(defcustom org-locus-journal-directory nil
  "Directory where all the journal entries are stored.")

(defcustom org-locus-journal-file-ending "txt"
  "File ending for the Journal files. Default: txt")

(defcustom org-locus-id-seperator "-"
  "Seperator that sperates the ID from the rest of the filename.
Example: 201712241055-test.org 
Default Seperator is '-'
Used in the split-string function, so a regular expression can be applied.")

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
			   org-locus-id-seperator
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
			       org-locus-id-seperator))))

(defun org-locus-path-at-point ()
  "Returns the Path / ID of the Link at point."
  (org-element-property :path (org-element-context)))

(defun org-locus-filename-to-id (filename)
  "Gets the filename, returns the ID.
Filename format: 201712241055-hello-world.txt"
  (first (split-string filename org-locus-id-seperator)))

(defun org-locus-insert-backlink ()
  "Insert backlink for Node: Parent: or Child: Link.
If Links already exists do nothing."
  (interactive)
  (let ((link-id (org-element-property :path (org-element-context)))
	(type (org-element-property :type (org-element-context)))
	(id (org-locus-filename-to-id (buffer-name))))
    (org-locus-append-link-unless-already-in-file link-id (org-locus-get-backlink-type type) id)))

(defun org-locus-append-link-unless-already-in-file (fileid linktype linkpath)
  "Inserts linktype:linkpath in file with fileid in org-locus notes directory."
  (let ((path (org-locus-id-to-path fileid))
	(link (concat linktype ":" linkpath)))
    (if (org-locus-is-string-in-file path link)
	(message (concat "Backlink " link " is already in file " path ". Nothing happened."))
      (progn (f-append-text (concat "\r\n" link) 'utf-8 path)
	     (message (concat "Backlink " link " was not in " path " and has been appended."))))))

(defun org-locus-get-backlink-type (type)
  (cond ((string= type "parent") "child")
	((string= type "child") "parent")
	((string= type "node") "node")))

;;(f-append-text text 'utf-8 path)

(defun org-locus-is-string-in-file (file searchstring)
  "true / false if searchstring is in file / not."
   (when (file-readable-p file)
     (with-temp-buffer
       (insert-file-contents file)
       (goto-char (point-min))
       (search-forward searchstring nil t))))
