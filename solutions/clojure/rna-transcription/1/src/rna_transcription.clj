(ns rna-transcription
  (:require [clojure.string :as str]))

(def rna-map
  {"C" "G"
   "G" "C"
   "A" "U"
   "T" "A"})

(defn to-rna [in]
  (let [valid (= "" (str/replace in #"[AUCGT]" ""))]
    (if valid
      (str/join (map #(get rna-map %) (str/split in #"")))
      (throw (AssertionError. "Invalid RNA strand")))))