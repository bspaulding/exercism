(ns sublist
  (require [clojure.data :refer [diff]]))

(defn slice [start n xs]
  (let [end (+ start n)]
   (take (- end start) (drop start xs))))

(defn sublist? [xs ys]
  (let [l (count xs)
        is (range 0 (- (count ys) (- l 1)))]
    (some #(= xs (slice % l ys)) is)))

(defn classify [xs ys]
  (cond
    (= xs ys) :equal
    (sublist? xs ys) :sublist
    (sublist? ys xs) :superlist
    :else :unequal))