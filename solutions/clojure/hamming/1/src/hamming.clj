(ns hamming)

(defn distance [a b]
  (if (= (count a) (count b))
    (let [pairs (map vector a b)
          bools (map #(= (first %) (second %)) pairs)]
      (count (filter not bools)))))