#
# CAUTION: This is wrong!  Works though
# REASON:  Wrong period length calculation
#          e.g. 0.1(3) counts as 2
#

# (1) take advantage of the fact that the period of a number n's reciprocal is
#     the smallest k such that n divides 10^k - 1.
#
# (2) only test prime numbers because cycle length would be identical for
#     mutiples. ie, n yields same and 2n

require 'mathn'

def cycle(x)
  p = 0
  d = 1
  divs = []
  while true do
    divs << d
    p += 1
    d *= 10
    next if x > d
    d %= x
    return 0 if d == 0
    return p if divs.include? d
  end
end

max = 0
rec = 0
1.upto(999) do |n|
  c = cycle(n)
  puts n.to_s + " " + c.to_s #if c % 10 == 0
  if c > max
    max = c
    rec = n
  end
end
puts max
puts rec

__END__
puts cycle(2)
puts cycle(3)
puts cycle(5)
puts cycle(7)
