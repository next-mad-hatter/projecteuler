#
# $File$
# $Author$
# $Date$
# $Revision$
#

def side(p, a, b)
  (p[0]-b[0])*(a[1]-b[1]) < (a[0]-b[0])*(p[1]-b[1])
end

def origin(a, b, c)
  o = [0,0]
  side(o,a,b) == side(o,b,c) and side(o,c,a) == side(o,a,b)
end

count = 0
ARGF.each_line do |line|
  c = []
  line.strip.split(",").map(&:to_i).each_slice(2){|x| c << x}
  count +=1 if origin(*c)
end
puts count
