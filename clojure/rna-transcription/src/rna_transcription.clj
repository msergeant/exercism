(ns rna-transcription
  (:require [clojure.string :as str]))

(defn to-rna [dna] ;; <- arglist goes here
  (assert (re-matches #"[GCAT]+" dna))
  (-> dna
      (str/replace #"G" "j")
      (str/replace #"C" "G")
      (str/replace #"j" "C")
      (str/replace #"A" "U")
      (str/replace #"T" "A")))
