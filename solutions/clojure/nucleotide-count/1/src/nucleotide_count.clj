(ns nucleotide-count)

(def valid-nucleotide? (partial contains? #{\A \T \C \G}))

(defn count [c s]
  (if (valid-nucleotide? c)
   (clojure.core/count (filter (partial = c) s))
   (throw (Throwable. "Invalid nucleotide"))))

(defn nucleotide-counts [s]
  {\A (count \A s)
   \T (count \T s)
   \C (count \C s)
   \G (count \G s)})