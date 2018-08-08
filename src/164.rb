N = 9
L = 18

#
# Generates a list of all legit 3-digit combinations
#
def comb(n)
  res = []
  a = b = c = 0
  while a <= n do
    b = 0
    while a+b <= n do
      c = 0
      while a+b+c <= n do
        res << [a,b,c]
        c += 1
      end
      b += 1
    end
    a += 1
  end
  res
end
#puts comb(N).inspect

#
# Building the graph here
#
class Node
  attr_accessor :seq
  attr_accessor :next

  def to_s
  end
end
vert = comb(N)
$graph = []
vert.each{|x|
  v = Node.new
  v.seq = x
  $graph << v
}
$graph.each{|v|
  v.next = $graph.find_all{|x| v.seq[1] == x.seq[0] and v.seq[2] == x.seq[1]}
}

#
# Search (using DP for recursion)
#
$mem = Hash.new{|h,k| h[k] = nil}

def paths(v,l)
  return $mem[[v.seq,l]] if $mem[[v.seq,l]]
  return 0 if l == 0
  return 1 if l == 1
  $mem[[v.seq,l]] = v.next.map{|x| paths(x,l-1)}.inject(0){|x,y| x+y}
  return $mem[[v.seq,l]]
end

start = $graph.find_all{|v| v.seq[0] != 0}
sum = 0
start.each do |s|
  sum += paths(s,L)
end
puts sum
