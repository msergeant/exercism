(ns anagram
  (:use clojure.string))

(defn is-anagram? [s t]
  (and
    (not (= s t))
    (= (frequencies s) (frequencies t))))

(defn anagrams-for [word prospect-list] ;; <- arglist goes here
  (filter #(is-anagram?
             (lower-case word)
             (lower-case %1))
          prospect-list))
