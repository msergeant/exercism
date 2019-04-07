(ns rotational-cipher)

(defn rotate-char [shift]
  (fn [x]
    (let [a (int \a)
          z (int \z)
          A (int \A)
          Z (int \Z)
          num (int x)
          low (<= a num z)
          cap (<= A num Z)
          base (if low a A)
          shifted (- num base)]
    (if
      (or low cap)
      (char
         (+ base (mod (+ shift shifted) 26)))
      x))))

(defn rotate [text shift]
  (apply
    str
    (map
      (rotate-char shift)
      (seq text))))
