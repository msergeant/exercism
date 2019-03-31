(ns reverse-string)

(defn recursive-reverse [acc s]
  (let
    [last-char (last s)
     len (.length s)]
    (cond
      (= 0 len) acc
      :else (recursive-reverse
              (conj acc last-char)
              (subs s 0 (- len 1))))))

(defn reverse-string [s] ;; <- arglist goes here
  (apply str (seq (recursive-reverse [] s))))
