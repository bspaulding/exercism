(ns beer-song
  (require [clojure.string :as str]))

(defn pluralize [n sing pl]
  (if (= 1 n) sing pl))

(defn bottle-phrase [n]
  (if (= 0 n) "no more bottles" (str n " " (pluralize n "bottle" "bottles"))))

(defn stanza-2 [v]
  (let [v1 (- v 1)
        nextBottle (bottle-phrase v1)]
    (str "Take " (if (= 1 v) "it" "one") " down and pass it around, " nextBottle " of beer on the wall.\n")))
(def last-stanza "Go to the store and buy some more, 99 bottles of beer on the wall.\n")

(defn verse [v]
  (let [bottle (bottle-phrase v)]
    (str (str/capitalize bottle) " of beer on the wall, " bottle " of beer.\n"
      (if (= v 0) last-stanza (stanza-2 v)))))

(defn sing
  ([start] (sing start 0))
  ([start end]
    (let [verses (reverse (range end (+ 1 start)))]
      (str/join "\n" (map verse verses)))))