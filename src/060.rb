#
# $File$
# $Author$
# $Date$
# $Revision$
#

require 'prime'
require 'set'

class P
  def initialize
    @gen = Prime::EratosthenesGenerator.new
    @ps = Set[]
  end

  def to_a
    @ps.to_a
  end

  def to_set
    @ps.to_set
  end

  def next
    p = @gen.next
    @ps << p
    p
  end

  def upto(n)
    while @ps.empty? or @ps.max <= n do self.next end
    @ps.select{|p| p <= n}
  end

end

def split(n, count, primes)
  (yield []; return) if n == 0 and count == 0
  return if n < count or count == 0
  (yield [n]; return) if count == 1 and primes.include? n
  (1..(n/count)).select{|x| primes.include? x}.each{|x|
    split(n-x-(count-1)*(x-1), count-1, primes){|y| yield(
      [x] + y.map{|z| z + x - 1}
    )}
  }
end

if __FILE__ == $0
  sum = 2
  n = 4
  primes = P.new
  loop do
    puts "========"
    puts sum
    split(sum, 4, primes.upto(sum)) do |s|
      if s.permutation(2).all?{|x| true }
        puts s.inspect
        exit
      end
    end
    sum += 1
    exit if sum > 793
  end
end
