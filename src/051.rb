#
# $File$
# $Author$
# $Date$
# $Revision$
#

require 'prime'
require 'set'

class Set
  def powerset
    inject(Set[Set[]]) do |ps, item|
      ps.union(ps.map {|e| e.union(Set[item])})
    end
  end
end

def rem_digits(str, poss)
  res = str.dup
  poss.each{|i| res[i] = "_"}
  res
end

def yields(n)
  str = n.to_s
  cnt = Hash.new(0)
  poss = Hash.new{|h,k| h[k] = Set[]}
  (0..str.length-1).each do |i|
    cnt[str[i]] += 1
    poss[str[i]] << i
  end
  (1..cnt.values.max).each do |c|
    cnt.find_all{|_,v| v >= c}.map(&:first).each do |d|
      poss[d].powerset.find_all{|s| s.length == c}.each do |s|
        yield [c, rem_digits(str, s)]
      end
    end
  end
end

def search(n)
  primes = Prime::EratosthenesGenerator.new
  l = 0
  f = Hash.new(0)
  loop do
    p = primes.next
    if p.to_s.length > l
      l = p.to_s.length
      r = f.find{|_,v| v == n}
      return r.first if r
      f = Hash.new(0)
    end
    yields(p){|c,v| f[v] += 1}
  end
end

if __FILE__ == $0
  str = search(8)
  puts [str, "<-", [*0..9].find{|d| str.tr("_",d.to_s).to_i.prime?}].join(" ")
end
