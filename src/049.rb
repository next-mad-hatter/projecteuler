#
# $File$
# $Author$
# $Date$
# $Revision$
#

require 'prime'

def digits(n)
  n.to_i.to_s(10).split("") #.uniq
end

def prime_perms(n)
  digits(n).permutation.to_a.map{|x| x.join("").to_i}.select{|x| x.prime?}.uniq
end

def combs(a, m)
  a.permutation(m).to_a.map(&:sort).uniq
end

def sat(p)
  combs(prime_perms(p), 3).find{|x| x[2]-x[1] == x[1] - x[0]}
end

P = Prime.take_while{|x| x < 10000}.select{|x| x >= 1000}

P.each do |p|
  next unless q = sat(p)
  next unless q[0] == p
  puts q.join("")
end
