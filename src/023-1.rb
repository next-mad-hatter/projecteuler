def divs(n)
  s = 0
  1.upto(n-1).to_a.each do |x|
    s += x if n % x == 0
  end
  s
end

def abu(n)
  s = 0
  1.upto(n-1).to_a.each do |x|
    break if x > n/2.0
    s += x if n % x == 0
    return true if s > n
  end
  (s > n)
end

nums = []
1.upto(28123).to_a.each do |x|
#1.upto(100).to_a.each do |x|
  t = abu(x)
  if t
    nums << x
    puts x
    $stdout.flush
  end
end
