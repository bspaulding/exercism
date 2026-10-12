(ns grade-school)

(defn add [db student-name grade-num]
  (let [names (get db grade-num)
        new-names (into [] (concat names [student-name]))]
    (assoc db grade-num new-names)))

(defn grade [db grade-num]
  (get db grade-num []))

(defn sorted-reducer [db xs grade-num]
  (concat xs [grade-num (sort (grade db grade-num))]))

(defn sorted [db]
  (let [keys (sort (keys db))
        list (reduce (partial sorted-reducer db) [] keys)]
    (apply sorted-map list)))