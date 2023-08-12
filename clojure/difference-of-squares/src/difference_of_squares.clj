(ns difference-of-squares)

(defn square [n]
  (* n n))

(defn square-of-sum [stop]
  (square (reduce + (range 1 (+ 1 stop)))))

(defn sum-of-squares [stop]
  (reduce + (map square (range 1 (+ 1 stop)))))


(defn difference [stop]
  (- (square-of-sum stop) (sum-of-squares stop)))
