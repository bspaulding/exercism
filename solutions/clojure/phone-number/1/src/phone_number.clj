(ns phone-number
  (require [clojure.string :as str]))

(defn invalid? [n]
  (or
   (< (count n) 10)
   (and
    (> (count n) 10)
    (not (= \1 (first n))))))

(defn full-us? [n]
  (and
   (> (count n) 10)
   (= \1 (first n))))

(defn number [n]
  (let [digits (str/replace n #"\D" "")]
   (cond
    (invalid? digits) "0000000000"
    (full-us? digits) (str/join (drop 1 digits))
    :else digits)))

(defn area-code [n]
  (str/join (take 3 (number n))))

(defn pretty-print [n]
  (let [code (area-code n)
        digits (drop 3 (number n))
        d1 (str/join (take 3 digits))
        d2 (str/join (drop 3 digits))]
   (str "(" code ") " d1 "-" d2)))