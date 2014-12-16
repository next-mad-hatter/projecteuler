#
# $File$
# $Author$
# $Date$
# $Revision$
#

require 'prime'

def factors(n)
  n.prime_division.map(&:first)
end

def pass(n)
  factors(n).length == 4
end

n = 1
loop do
  if [n,n+1,n+2,n+3].all?{|x| pass(x)}
    puts n
    exit
  end
  n += 1
end
