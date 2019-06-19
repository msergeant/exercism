(ns pov)

(defn depth [x] (if (coll? x) (+ 1 (apply max (map depth x))) 0))

(defn inject-parent [node siblings parent level-reached?]
  (let [last-element (last node)]
    (if (coll? last-element)
      (if level-reached?
        (conj (into [] (drop-last node)) (conj last-element (concat [parent] siblings)))
        (conj (into [] (drop-last node)) (inject-parent last-element siblings parent false)))
      (conj node (into [] (concat [parent] siblings))))))

(defn build-pov [node level]
  (let [parent (first level)
        children (rest level)]
    (if (empty? children)
      (when (= node parent) level)
      (if (= node parent)
        level
        (let [povs (map #(build-pov node %) children)
             siblings (remove nil? (map #(when (nil? %2) %1) children povs))
             found-node (some identity povs)]
         (when found-node (inject-parent found-node siblings parent (= (depth found-node) (depth level)))))))))

(defn of [node full-graph] ;; <- arglist goes here
  (build-pov node full-graph))

(defn path-from-to [] ;; <- arglist goes here
  ;; your code goes here
)
