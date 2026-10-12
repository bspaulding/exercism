(ns anagram
  (require [clojure.string :as str]))

(defn char-counts-reducer [counts char]
  (assoc counts char (+ 1 (get counts char 0))))
(defn char-counts [string]
  (reduce char-counts-reducer {} string))

(defn anagrams-for [word words]
  (let [lowerWord (str/lower-case word)
        expected (char-counts lowerWord)
        filteredWords (filter #(not (= lowerWord (str/lower-case %))) words)]
    (filter #(= expected (char-counts (str/lower-case %))) filteredWords)))