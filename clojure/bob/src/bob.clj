(ns bob
  (:use clojure.string))

(defn question? [s]
  (ends-with? s "?"))

(defn all-caps? [s]
  (and
    (re-find #"[A-Z]" s)
    (= s (upper-case s))))

(defn all-caps-question? [s]
  (and (all-caps? s) (question? s)))

(defn response-for [s] ;; <- arglist goes here
  (cond
    (blank? s) "Fine. Be that way!"
    (all-caps-question? s) "Calm down, I know what I'm doing!"
    (question? s) "Sure."
    (all-caps? s) "Whoa, chill out!"
    :else "Whatever."))
