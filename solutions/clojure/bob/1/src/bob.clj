(ns bob
  (:require [clojure.string :refer [includes?, ends-with?, replace, upper-case]]))

(defn response-for [msg]
  (let [allUpperCase (= msg (upper-case msg))
        allSpace (= "" (replace msg #"\s" ""))
        allNumbers (= "" (replace msg #"[0-9, ?]" ""))
        forceful (and allUpperCase (not allNumbers))
        question (ends-with? msg "?")]
    (cond
      allSpace "Fine. Be that way!"
      forceful "Whoa, chill out!"
      question "Sure."
      :else "Whatever.")))