def tri(n)
   n * (n+1) / 2
end

def gcd(x,y)
  return x if y == 0
  return y if x == 0
  return gcd( y, x - y*(x/y).floor )
end

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
  end
  primes
end

$primes = []

def factors(x)
  return {} if x == 1

  f = Hash.new{|h,k| h[k] = nil}
  $primes = all_primes($primes,x)

  lim = Math.sqrt(x)

  $primes.each do |p|
    return f if x == 1
    i = 0
    while x % p == 0 do
      i += 1
      x /= p
    end
    f[p] = i if i > 0
  end
  return f if x == 1
  raise "Factorization error: #{x}"
end

def merge(a,b)
  b.each_key do |p|
    if a[p]
      a[p] = a[p] + b[p]
    else
      a[p] = b[p]
    end
  end
  return a
end

def tri_factors(n)
  a = n
  b = n+1
  f = Hash.new{|h,k| h[k] = nil}

  if a % 2 == 0
    a /= 2
  else
    b /= 2
  end
  c = gcd(a,b)
  a /= c
  b /= c

  f = merge(merge(factors(a),factors(b)),factors(c))

  p = 1
  f.each_key do |x|
    p *= (f[x] + 1)
  end
  return p
end

n = 1
fp = 0
while true do
  f = tri_factors(n)
  if f > fp
    print n.to_s
    print "  "
    puts f
    fp = f
  end
  n += 1
end
