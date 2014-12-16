#
# $File$
# $Author$
# $Date$
# $Revision$
#

require 'prime'
require 'mathn'
require 'rational'
require 'gmp'

# n \in 1+2\mathbb{N}_0
def diag_count(mem, n)
  return 0 if n < 2
  mem[n] ||= [n**2-n+1, n**2-2*n+2, n**2-3*n+3].count(&:prime?) +
             diag_count(mem, n-2)
end

def diag(mem=nil)
  mem ||= []
  lambda{|n| diag_count(mem, n)}
end

f, n, delta = diag, 1, 1
loop do
  d = 2*n+1
  p = (f.call(d)/(4*n+1)).to_f
  if p < delta or p < 0.1
    puts [d, p].join(" ")
    delta = p - 0.01
    exit if p < 0.1
  end
  n += 1
end
