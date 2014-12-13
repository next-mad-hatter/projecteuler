require 'mathn'
require 'matrix'

LEN = 10
def p(n)
  #1−n+n**2−n**3+n**4−n**5+n**6−n**7+n**8−n**9+n**10
  1 -
  n +
  n**2 -
  n**3 +
  n**4 -
  n**5 +
  n**6 -
  n**7 +
  n**8 -
  n**9 +
  n**10
end

#LEN = 3
#def p(n)
#  n**3
#end

values = 1.upto(LEN).to_a.map{|i| p(i)}

sum = 0
1.upto(values.length) do |n|
  b = values[0...n]
  rows = 1.upto(n).to_a.map{|i|
    n.downto(1).to_a.map{|j|
      i**(j-1)
    }
  }
  a = (Matrix.rows(rows).inverse * Vector.elements(b)).to_a
  #puts a.inspect
  fit = 0
  a.each_index{|i| fit += a[i] * ((a.length + 1)**(a.length - i - 1))}
  #puts fit
  sum += fit
end
puts sum
