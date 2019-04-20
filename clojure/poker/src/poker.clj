(ns poker
  (:require [clojure.string :refer [join split includes?]]))

(defn rank-face-card [ch]
  (case ch
    "1" "A"
    "J" "B"
    "Q" "C"
    "K" "D"
    "A" "E"
    ch))

(defn just-ranks [hand]
  (let [chrs (map
               #(rank-face-card (subs % 0 1))
               (split hand #" "))
        freq (frequencies chrs)]
    (reverse
      (sort-by (juxt #(get freq %) identity) chrs))))

(defn rank-val [hand]
  (read-string (apply
                 str
                 "0x"
                 (join (just-ranks hand)))))

(defn rank-frequencies [hand]
  (-> hand
      just-ranks
      frequencies))

(defn single-pair? [freq]
  (= 2 (apply max (vals freq))))

(defn two-pair? [freq]
  (= 2 (count (filter #(= % 2) (vals freq)))))

(defn three-of-a-kind? [freq]
  (= 3 (apply max (vals freq))))

(defn straight? [hand]
  (let [nums (map #(read-string (apply str "0x" %)) (just-ranks hand))
        first-card (first nums)
        second-card (second nums)]
    (or
      (every? identity (map-indexed #(= %2 (- first-card %1)) nums))
      (and (= 14 first-card)
           (every?
             identity
             (map-indexed #(= %2 (- second-card %1)) (rest nums)))))))

(defn flush? [hand]
  (apply = (re-seq #"[A-Z]" hand)))

(defn full-house? [freq]
  (= '(2 3) (sort (vals freq))))

(defn four-of-a-kind? [freq]
  (= 4 (apply max (vals freq))))

(defn poker-val [hand]
  (let [freq (rank-frequencies hand)
        straight (straight? hand)
        flsh (flush? hand)]
    (cond
      (and flsh straight)     0x800000
      (four-of-a-kind? freq)  0x700000
      (full-house? freq)      0x600000
      flsh                    0x500000
      straight                0x400000
      (three-of-a-kind? freq) 0x300000
      (two-pair? freq)        0x200000
      (single-pair? freq)     0x100000
      :else 0)))

(defn numeric-val [hand]
  (let [pv (poker-val hand)
        rank (rank-val hand)
        wheel? (and
                 (straight? hand)
                 (includes? hand "A")
                 (includes? hand "2"))
        rv (if wheel? 1 rank)]
    (+ rv pv)))

(defn best-hands [hands] ;; <- arglist goes here
  (cond
    (= 1 (.length hands)) hands
    :else (let [numerics (reduce #(assoc %1 %2 (numeric-val %2)) {} hands)
                top (apply max (vals numerics))]
            (filter #(= top (get numerics %)) hands))))
