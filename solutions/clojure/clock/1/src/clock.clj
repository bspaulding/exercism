(ns clock)

(def minutesInDay (* 24 60))

(defn clock [hours minutes]
  (mod
    (+ minutes (* 60 hours))
    minutesInDay))

(defn add-time [clock minutes]
  (mod
    (+ clock minutes)
    minutesInDay))

(defn pad [n]
  (if (< n 10)
    (str "0" n)
    (str n)))

(defn clock->string [clock]
  (let [hours (int (Math/floor (/ clock 60)))
        minutes (int (Math/floor (mod clock 60)))]
    (str (pad hours)  ":"  (pad minutes))))