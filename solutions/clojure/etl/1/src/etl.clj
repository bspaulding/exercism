(ns etl
  (require [clojure.string :refer [lower-case]]))

(defn transform [data]
  (reduce-kv
    (fn [m k words]
      (reduce
        (fn [m word]
          (assoc m (lower-case word) k))
        m
        words))
    {}
    data))