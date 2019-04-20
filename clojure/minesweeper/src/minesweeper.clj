(ns minesweeper
  (:require [clojure.string :refer [join split-lines]]))

(def line-separator (System/getProperty "line.separator"))

(defn count-mines [grid x y length width]
  (let [sum (reduce + (for [i [-1 0 1] j [-1 0 1]]
                        (if
                          (and (<= 0 (+ x i) (- width 1))
                               (<= 0 (+ y j) (- length 1))
                               (= \* (nth (nth grid (+ y j)) (+ x i))))
                          1
                          0)))]
    (if (> sum 0) sum \space)))

(defn draw [lines]
  (if (= lines "")
    ""
    (let [grid (map seq (split-lines lines))
          length (count grid)
          width (count (nth grid 0))]
      (->> (for [x (range width) y (range length)]
            (let [c (nth (nth grid y) x)]
              (if (= c \space)
                (count-mines grid x y length width)
                c)))
          (partition width)
          (map #(apply str %))
          (join line-separator)))))
