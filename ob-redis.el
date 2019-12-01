;;; ob-redis.el --- Execute Redis queries within org-mode blocks.
;; Copyright 2016 stardiviner

;; Author: stardiviner <numbchild@gmail.com>
;; Maintainer: stardiviner <numbchild@gmail.com>
;; Maintainer: nekifirus <nekifirus@gmail.com>
;; Keywords: org babel redis
;; URL: https://github.com/stardiviner/ob-redis
;; Created: 28th Feb 2016
;; Modified: 1th Dec 2019
;; Version: 0.0.2
;; Package-Requires: ((org "8"))

;;; Commentary:
;;
;; Execute Redis queries within org-mode blocks.
;; Can set parameters
;; :host - ip-address of redis host
;; :port - port of redis host
;; :db - db number in redis

;;; Code:
(require 'org)
(require 'ob)

(defgroup ob-redis nil
  "org-mode blocks for Redis."
  :group 'org)

(defcustom ob-redis:default-host "127.0.0.1"
  "Default ip-address for redis host."
  :group 'ob-redis
  :type 'string)

(defcustom ob-redis:default-port 6379
  "Default port for redis host."
  :group 'ob-redis
  :type 'integer)

(defcustom ob-redis:default-db 0
  "Default Redis database."
  :group 'ob-redis
  :type 'integer)

;;;###autoload
(defun org-babel-execute:redis (body params)
  "Org-babel redis hook.
Argument BODY body of org source block.
Argument PARAMS org-babel params."
  (let* ((host (or (cdr (assoc :host params))
                   ob-redis:default-host))
         (port (or (cdr (assoc :port params))
                   ob-redis:default-port))
         (db (or (cdr (assoc :db params))
                 ob-redis:default-db))
         (cmd (format "redis-cli -h %s -p %s -n %s" host port db)))
    (org-babel-eval cmd body)))

;;;###autoload
(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("redis" . redis)))

(provide 'ob-redis)

;;; ob-redis.el ends here
