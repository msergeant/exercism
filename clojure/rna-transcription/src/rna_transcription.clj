(ns rna-transcription
  (:require [clojure.string :as str]))

(def dna-map
  {\C \G
   \G \C
   \A \U
   \T \A})

(defn to-rna [dna] ;; <- arglist goes here
  (assert (re-matches #"[GCAT]+" dna))
  (->> dna
      (into [])
      (map #(get dna-map %))
      (str/join)))
