#
# $File$
# $Author$
# $Date$
# $Revision$
#

def nat_0(x)
  x.to_i == x.abs
end

def tri(n)
  n*(n+1)/2
end

def penta(n)
  n*(3*n-1)/2
end

def hexa(n)
  n*(2*n-1)
end

def inv_tri(x)
  n = (Math::sqrt(8*x+1) - 1)/2
  if nat_0(n) then n.to_i else nil end
end

def inv_penta(x)
  n = (Math::sqrt(24*x+1) + 1)/6
  if nat_0(n) then n.to_i else nil end
end

def inv_hexa(x)
  n = (Math::sqrt(8*x+1) + 1)/4
  if nat_0(n) then n.to_i else nil end
end

n = 286
loop do
  t = tri(n)
  if inv_penta(t) and inv_hexa(t)
    puts t
    exit
  end
  n +=1
end
