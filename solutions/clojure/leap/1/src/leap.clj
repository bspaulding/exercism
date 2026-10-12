(ns leap)

(defn leap-year? [n]
  (cond
    (= 0 (mod n 400)) true
    (= 0 (mod n 100)) false
    (= 0  (mod n 4)) true
    :else false))