					; ======================== CHRIS ==========================
					; =============================================================


(require 'org)
(defcustom chris-note-directory nil
  "Directory where all the notes are stored.")

(defcustom chris-journal-directory nil
  "Directory where all the journal entries are stored.")

(defcustom chris-journal-file-ending "txt"
  "File ending for the Journal files. Default txt")

(defcustom chris-id-seperator "-"
  "Seperator that sperates the ID from the rest of the filename.
Example 201712241055-test.org 
Default Seperator is '-'
Used in the split-string function, so a regular expression can be applied.")

(defcustom chris-tag-file "index.org"
  "File where the tags are stored.")

(defcustom chris-list-of-tags '("psychologie" "informatik" "status" "attraktion")
  "List with all tags in file system.")

(defun chris-new-note (name)
  "Create a new Note with the given name."
  (interactive "sName of the new note ")
  (find-file (substitute-in-file-name (concat
				       chris-note-directory
				       "/"
				       (format-time-string "%Y%m%d%H%M-")
				       name
				       ".org"))))


;; source http//steve.yegge.googlepages.com/my-dot-emacs-file
(defun chris-rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name ")
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

(defun chris-rename-note (name)
  "Rename the open buffer and file but keep the ID at the beginning."
  (interactive "sNew name ")
  (chris-rename-file-and-buffer (concat
			   (first (split-string (buffer-name) "-"))
			   chris-id-seperator
			   name
			   ".org")))

(defun chris-journal-entry (date)
  "Open Journal Entry for Entered day. Date Format 2017-01-31. If empty jump to Journal entry for today."
  (interactive "sDate ")
  (if (or (chris-check-if-iso-date date) (= (length date) 0) (chris-check-if-iso-date-without-year date))
      (find-file (substitute-in-file-name (concat
					   chris-journal-directory
					   "/"
					   (cond ((= (length date) 0) (format-time-string "%Y-%m-%d"))
						 ((= (length date) 5) (concat (format-time-string "%Y-") date))
						 (t date))
					   "."
					   chris-journal-file-ending)))
    (message (concat "\"" date "\" is neither an empty string nor a valid ISO-Date String."))))


(defun chris-check-if-iso-date (string)
  (string-match "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}" string))

(defun chris-check-if-iso-date-without-year (string)
  (string-match "[0-9]\\{2\\}-[0-9]\\{2\\}" string))

(defun chris-open-file-by-id (id)
  "Open the file in Note or File with the given ID. If the ID is not unique, the first found file is opened. Requirement be in Note directory."
  (interactive "sID ")
  (find-file (chris-id-to-path id)))


					; ========= ORG-LINK DEFINITIONS

(org-link-set-parameters "note"
 :follow 'chris-open-file-by-id
 :face '(foreground "red" underline t)
 :help-echo 'chris-filename-tooltip
 :complete (lambda () (chris-link-complete "note")))

(org-link-set-parameters "parent"
 :follow 'chris-open-file-by-id
 :face '(foreground "red" underline t)
 :help-echo 'chris-filename-tooltip
 :complete (lambda () (chris-link-complete "parent")))

(org-link-set-parameters "child"
 :follow 'chris-open-file-by-id
 :face '(foreground "red" underline t)
 :help-echo 'chris-filename-tooltip
 :complete (lambda () (chris-link-complete "child")))

(org-link-set-parameters "tag"
 :follow '(chris-list-files-that-contain-string (concat "tag:" chris-path-at-point))
 :face '(foreground "red" underline t)
 :help-echo "Ein Tag"
 :complete (lambda () (concat "tag:" (completing-read "Choose Tag: " chris-list-of-tags))))

(defun chris-filename-tooltip (window object position)
  "Returns the full filename of the Link ID at pointer as string."
  (save-excursion
    (goto-char position)
    (message
     (chris-id-to-path (org-element-property :path (org-element-context))))))

(defun chris-id-to-path (id)
  "Returns the full path for a note given it's ID."
  (first (file-name-all-completions id (substitute-in-file-name chris-note-directory))))

(defun chris-link-complete (link)
  (concat link
	  ":"
	  (first (split-string (first (last (split-string
					     (read-file-name "Choose file to link ")
					     "/")))
			       chris-id-seperator))))

(defun chris-path-at-point ()
  "Returns the Path / ID of the Link at point."
  (org-element-property :path (org-element-context)))

(defun chris-filename-to-id (filename)
  "Gets the filename, returns the ID.
Filename format 201712241055-hello-world.txt"
  (first (split-string filename chris-id-seperator)))

(defun chris-insert-backlink ()
  "Insert backlink for Node Parent or Child Link.
If Links already exists do nothing."
  (interactive)
  (let ((link-id (org-element-property :path (org-element-context)))
	(type (org-element-property :type (org-element-context)))
	(id (chris-filename-to-id (buffer-name))))
    (chris-append-link-unless-already-in-file link-id (chris-get-backlink-type type) id)))

(defun chris-append-link-unless-already-in-file (fileid linktype linkpath)
  "Inserts linktypelinkpath in file with fileid in chris notes directory."
  (let ((path (chris-id-to-path fileid))
	(link (concat linktype ":" linkpath)))
    (if (chris-is-string-in-file path link)
	(message (concat "Backlink " link " already appears in file \"" path "\". Nothing happened."))
      (progn (f-append-text (concat "\r\n" link) 'utf-8 path)
	     (message (concat "Backlink " link " has been appended to file \"" path "\"."))))))

(defun chris-get-backlink-type (type)
  (cond ((string= type "parent") "child")
	((string= type "child") "parent")
	((string= type "note") "note")))


;;(f-append-text text 'utf-8 path)

(defun chris-is-string-in-file (file searchstring)
  "true / false if searchstring is in file / not."
   (when (file-readable-p file)
     (with-temp-buffer
       (insert-file-contents file)
       (goto-char (point-min))
       (search-forward searchstring nil t))))

(defun chris-replace-all-occurences (string replace-with)
  "Replaces all occurences of string with replace-with. (In current buffer or temproary buffer)"
  (save-excursion
    (goto-char (point-min))
    (while (search-forward string nil t)
      (replace-match replace-with))))

(defun chris-replace-all-occurences-in-file (file string replace-with)
  "Replace all occurences of the regular expression string in file wiht replace-with."
  (when (file-readable-p file)
    (with-temp-buffer
      (insert-file-contents file)
      (goto-char (point-min))
      (while (re-search-forward string nil t)
	(replace-match replace-with))
      (write-file file))))

;; remove link at point and backlink
(defun chris-remove-link-and-backlink-at-point ()
  "Removes both the link at point and be backlink in the referenced file."
  (interactive)
  (let ((link-id (org-element-property :path (org-element-context)))
	(link-type (org-element-property :type (org-element-context)))
	(my-id (chris-filename-to-id (buffer-name))))
    (let ((my-type (chris-get-backlink-type link-type)))
      (chris-replace-all-occurences  (chris-make-link link-type link-id) "")
      (chris-replace-all-occurences-in-file (chris-id-to-path link-id) (chris-make-link my-type my-id) ""))))

(defun chris-make-regular-expression-for-link (path)
  (concat "\\[?\\[?" path "\\]?\\]?"))

(defun chris-make-backlink (type path)
  "Makes the backlink. Type is the type that links to the backlink (so gets reversed)"
  (chris-make-link (chris-get-backlink-type type) path))

(defun chris-make-link (type path)
  "Make a link from type and path."
  (concat type ":" path))

(defun chris-remove-all-occurences-in-buffer (string)
  (interactive "sString ")
  (chris-replace-all-occurences string ""))

(defun chris-list-files-that-contain-string (links)
  (interactive "sFuck:")
  (deft-setup)
  (deft-filter "test")
  (setq deft-filter-regexp "testt"))
