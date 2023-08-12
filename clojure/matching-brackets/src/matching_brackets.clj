(ns matching-brackets)

; inspired by https://stackoverflow.com/a/37083851/1825390

(def pairs {"{"  "}"
            "["   "]"
            "(" ")"})

(defn is-bracket [b] (contains? #{\[ \( \{ \} \) \]} b))



(defn brackets-only [s]
  (filter is-bracket s))

; not working, but I'm sort of at the limit of my clojure for now

(defn valid? [s]
  (let [stack (atom [])]
    (reduce (fn [res, val]
              (if (contains? pairs val)
                (swap! stack conj val)
                (if (= (peek @stack) (get pairs val))
                  (swap! stack pop)
                  (reduced false))))
            false
            (brackets-only s))))
