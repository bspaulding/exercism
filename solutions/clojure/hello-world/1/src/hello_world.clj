(ns hello-world)

(defn hello
  ([name]
   (str "Hello, " name "!"))
  ([]
   (str "Hello, World!")))