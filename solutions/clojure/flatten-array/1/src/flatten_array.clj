(ns flatten-array)

(defn flatten [xs]
  (let [h (first xs)
        t (drop 1 xs)
        flat-head (cond
                    (vector? h) (flatten h)
                    (nil? h) []
                    :else [h])]
    (if (empty? t)
      flat-head
      (into [] (concat flat-head (flatten t))))))