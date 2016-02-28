;;; ob-redis.el --- Execute mongodb queries within org-mode blocks.
;; Copyright 2013 Kris Jenkins

;; Author: Kris Jenkins <krisajenkins@gmail.com>
;; Maintainer: Kris Jenkins <krisajenkins@gmail.com>
;; Keywords: org babel mongo mongodb
;; Package-Version: 20130718.732
;; URL: https://github.com/stardiviner/ob-redis
;; Created: 17th July 2013
;; Version: 0.0.1
;; Package-Requires: ((org "8"))

;;; Commentary:
;;
;; Execute Redis queries within org-mode blocks.

;;; Code:
(require 'org)
(require 'ob)

(defgroup ob-redis nil
  "org-mode blocks for MongoDB."
  :group 'org)

(defcustom ob-redis:default-db nil
  "Default Redis database."
  :group 'ob-redis
  :type 'string)

;;;###autoload
(defun org-babel-execute:redis (body params)
  "org-babel redis hook."
  (let* ((db (or (cdr (assoc :db params))
                 ob-redis:default-db))
         (cmd (mapconcat 'identity (list "redis-cli") " ")))
    (org-babel-eval cmd body)
    ))

;;;###autoload
(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("redis" . redis)))

(provide 'ob-redis)

;;; ob-redis.el ends here
