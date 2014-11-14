#
# = $File$ : 
#
# Author::           Max Deineko
# Documentation::    Max Deineko
#
# $Author$
# $HGDate$
# $Revision$
#

def prime?(primes,x)
  lim = Math.sqrt(x)
  primes.each do |p|
    return true if p > lim
    return false if x % p == 0
  end
  return true
end

def next_primes(primes)
  return [2] if primes.empty?
  n = primes[-1] + 1
  while true do
    return (primes+[n]) if prime?(primes,n)
    n += 1
  end
end

def all_primes(primes, lim)
  while primes.empty? or primes[-1] < lim do
    primes = next_primes(primes)
    if primes.length % 1000 == 0
      print primes.length
      print "  "
      puts primes.last.inspect
    end
  end
  primes
end

def bisect(a,x)
  return false if a.empty?
  return a[0] == x if a.length == 1
  i = a.length / 2
  return true if a[i] == x
  if a[i] < x
    return bisect(a[i+1..-1],x)
  else
    return bisect(a[0..i-1],x)
  end
end

def rots(p)
  r = []
  s = p.to_s.split("")
  0.upto(s.length - 2) do |i|
    r << (s[i+1..-1] + s[0..i]).join('').to_i
  end
  return r
end

#$primes = all_primes([], 10**2 - 1)
$primes = all_primes([], 10**6 - 1)

puts
puts " RES "
puts

$c = 0
$primes.each do |p|
  if [[true],[]].include? rots(p).map{|x| bisect($primes,x)}.uniq
    puts p
    $c += 1
  end
end

puts
puts " COUNT "
puts

puts $c
