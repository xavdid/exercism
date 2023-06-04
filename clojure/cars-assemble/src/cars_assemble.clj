(ns cars-assemble)

(defn production-rate
  "Returns the assembly line's production rate per hour,
   taking into account its success rate"
  [speed] (cond
            (< speed 5) (* speed 221.0)
            (< speed 9) (* speed 221.0 0.9)
            (= speed 9) (* speed 221.0 0.8)
            (= speed 10) (* speed 221.0 0.77)))

(defn working-items
  "Calculates how many working cars are produced per minute"
  [speed]
  (-> speed
      production-rate
      (/ 60)
      Math/floor
      int))


