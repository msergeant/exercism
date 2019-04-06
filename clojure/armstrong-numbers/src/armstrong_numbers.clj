(ns armstrong-numbers)

(defn armstrong? [num] ;; <- arglist goes here
  (let [strnum (str num)
        digits (.length strnum)]
    (=
     num
     (reduce
       #(+ %1 (.pow (biginteger (str %2)) (biginteger digits)))
       0
       strnum))))
