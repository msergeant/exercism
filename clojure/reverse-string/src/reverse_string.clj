(ns reverse-string)

(defn reverse-string [s] ;; <- arglist goes here
  ;(apply str (seq (recursive-reverse [] s))))
  (let [r ""
        i (count s)]
    (loop [r ""
           f s]
      (if (= 0 (count f))
        r
        (recur (str r (str (last f)))
               (subs s 0 (- (count f) 1)))))))
