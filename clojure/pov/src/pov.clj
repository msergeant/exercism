(ns pov)

(defn depth [x] (if (coll? x) (+ 1 (apply max (map depth x))) 0))

(defn inject-parent [node siblings parent direct-children]
  (let [last-element (last node)
        node-key (first node)]
    (if (and (coll? last-element) (not-any? #(= node-key %) direct-children))
      (conj (into [] (drop-last node))
            (inject-parent last-element siblings parent direct-children))
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
              found-node (some identity povs)
              direct-children (map first children)]
          (when found-node
            (inject-parent found-node siblings parent direct-children)))))))

(defn of [node full-graph] ;; <- arglist goes here
  (build-pov node full-graph))

(defn path-from-to [] ;; <- arglist goes here
  ;; your code goes here
)
