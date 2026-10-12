(ns perfect-numbers)

(defn proper-divisors [x]
  (filter
    #(= 0 (mod x %))
    (range 1 x)))

(defn aliquot-sum [x]
  (reduce + (proper-divisors x)))

(def memoized-aliquot-sum (memoize aliquot-sum))

(defn perfect? [x]
  (= x (memoized-aliquot-sum x)))

(defn abundant? [x]
  (> (memoized-aliquot-sum x) x))

(defn deficient? [x]
  (< (memoized-aliquot-sum x) x))

(defn classify [x]
  (cond
    (< x 0) (throw (IllegalArgumentException.))
    (perfect? x) :perfect
    (abundant? x) :abundant
    (deficient? x) :deficient
    :else nil))