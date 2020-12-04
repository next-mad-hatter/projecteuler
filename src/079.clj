(ns madhat.projecteuler
  (:require [clojure.string :as str]))

(defn input->words [input]
  (as-> input $
    (str/split $ #"\R+")
    (map seq $)
    (into #{} $)))

(def words
  (->>
   "079_keylog.txt"
   (slurp)
   (input->words)))

(def shortest
  (letfn [(shorten-word [ch word]
            (if (= ch (first word)) (next word) word))
          (shorten-words [ch words]
            (->> words
                 (map (partial shorten-word ch))
                 (remove nil?)
                 (into #{})))]
    (memoize
     (fn [words]
       (if (empty? words)
         ""
         (let [prefixes     (distinct (map first words))
               suffixes     (map #(shorten-words % words) prefixes)
               subsolutions (map shortest suffixes)
               solutions    (map cons prefixes subsolutions)]
           (apply min-key count solutions)))))))

(time
 (->> words
      shortest
      (apply str)))
