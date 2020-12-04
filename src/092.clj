(ns madhat.projecteuler
  (:require #_[clojure.set :as set]
            [clojure.math.combinatorics :as combo]
            [clojure.string :as str]))

;;
;; Solution 1: appr. 60sec
;;

(comment

  (defn square [n]
    (as-> n $
      (str $)
      (str/split $ #"")
      (map read-string $)
      (map #(* % %) $)
      (apply + $)))

  ;; https://stackoverflow.com/questions/3906831/how-do-i-generate-memoized-recursive-functions-in-clojure
  (defn make-fixpoint []
    (with-local-vars
      [fixp (memoize
             (fn [x]
               (if (#{0 1 89} x)
                 x
                 (fixp (square x)))))]
      (.bindRoot fixp @fixp)
      @fixp))

  (def fixpoint (make-fixpoint))

  (defn how-many [below]
    (->> below
         (range 1)
         (map fixpoint)
         (filter #{89})
         count))

  (time
   (def answer
     (how-many 10000)))

  answer) ;; => 8581146 in appr 60 seconds

;;
;; Solution 2: under 300msec
;;

(defn digits [n]
  (->> n
       (iterate #(quot % 10))
       (take-while pos?)
       (mapv #(mod % 10))
       rseq))

(defn content-of [n]
  (->> n digits sort))

;; NB: this is slow!  Since our upper bound is a power of 10,
;; we'll generate all sorted lists of digits and map multinomial coefficients instead
;; (defn freqs-below [n]
;;   (->> n (range 1) (map content-of) frequencies))

(defn freqs-below-10mil []
  (let [vs (for [x0 (range 10)
                 x1 (range x0 10)
                 x2 (range x1 10)
                 x3 (range x2 10)
                 x4 (range x3 10)
                 x5 (range x4 10)
                 x6 (range x5 10)
                 ]
             (seq [x0 x1 x2 x3 x4 x5 x6
                   ]))
        fs (map combo/count-permutations vs)]
      (zipmap vs fs)))

(defn pad [s n]
  (let [m (count s)]
    (concat (repeat (- n m) 0) s)))

(defn make-fixpoint [padding]
  (with-local-vars
    [fixp (memoize
           (fn [sorted-digits]
             (let [sum (apply + (map #(* % %) sorted-digits))]
               (if (#{0 1 89} sum)
                 sum
                 (fixp (pad (content-of sum) padding))))))]
    (.bindRoot fixp @fixp)
    @fixp))

;; Padding is not strictly necessary, but helps us not waste memoized values
;; due to difference in what content-of returns and the keys of freqs map
(def fixpoint-of (make-fixpoint 7))

(defn comp-fixpoints [freqs]
  (into [] (for [[k v] freqs] [(fixpoint-of k) v])))

(time
 (def answer
   (let [freqs     (freqs-below-10mil)
         fixpoints (comp-fixpoints freqs)
         selected  (filter #(= 89 (first %)) fixpoints)
         totals    (map #(nth % 1) selected)]
     (apply + totals))))

answer ;; => 8581146 in < 300msec

;; 100   ->   80
;; 1000  ->  857
;; 10000 -> 8558
