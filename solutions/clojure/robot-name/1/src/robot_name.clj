(ns robot-name)

(def letters (map char (range 65 91)))
(def two-letter-codes
  (into []
    (mapcat (fn [a] (map (fn [b] (str a b)) letters)) letters)))

(defonce num-names (atom 0))
(defn next-i []
  (let [i @num-names]
    (swap! num-names inc)
    i))

(defn make-name-i [i]
  (let [code (get two-letter-codes (int (/ i 1000)))
        n  (mod i 1000)]
    (str code (format "%03d" n))))
(defn make-name [] (make-name-i (next-i)))

(defn robot [] (atom {:name (make-name)}))

(defn robot-name [robot] (:name @robot))

(defn reset-name [robot]
  (swap! robot assoc :name (make-name)))