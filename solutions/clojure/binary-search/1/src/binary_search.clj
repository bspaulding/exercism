(ns binary-search)

(defn at [i xs]
  (first (drop i xs)))

(defn middle [xs]
  (int (/ (count xs) 2)))

(defn search-for-recur [x xs]
  (if (empty? xs)
    nil
    (let [im (middle xs)
          m (at im xs)]
      (cond
        (= m x) im
        (= im 0) nil
        :else (let [left (search-for-recur x (take im xs))
                    right (search-for-recur x (drop im xs))]
                (cond
                  left left
                  right (+ im right)
                  :else nil))))))

(defn search-for [x xs]
  (let [i (search-for-recur x xs)]
    (if (nil? i)
      (throw (Throwable. "not found"))
      i)))