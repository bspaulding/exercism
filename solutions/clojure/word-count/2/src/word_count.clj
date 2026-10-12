(ns word-count
  (require [clojure.string :as str]))

(defn word-count-reducer [counts word]
  (assoc counts word (+ 1 (get counts word 0))))

(defn word-count [in]
  (let [sanitized (str/replace in #"[^\w\s]" "")
        words (str/split sanitized #"\s+")
        lowered (map str/lower-case words)]
    (reduce word-count-reducer {} lowered)))