(ns robot-name
  (:require [clojure.string :as str]))

(defn three-digit-string [] (format "%03d" (rand-int 999)))
;; doesn't have to be the whole alphabet
(defn two-letters [] (->> "ABCDEFGHIJKLMNOP" seq shuffle (take 2) str/join))
(defn gen-name [_] (format "%s%s" (two-letters) (three-digit-string)))

(defn robot []
  (atom nil))

(defn robot-name [robot]
  (if (= @robot nil)
    (swap! robot gen-name)
    @robot))

(defn reset-name [robot]
  (reset! robot nil))
