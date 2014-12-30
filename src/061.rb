#
# $File$
# $Author$
# $Date$
# $Revision$
#

def nat_0(x)
  x.to_i == x.abs
end

def inv_tri(x)
  n = (Math::sqrt(8*x+1) - 1)/2
  if nat_0(n) then n.to_i else nil end
end

def inv_square(x)
  n = Math::sqrt(x)
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

def inv_hepta(x)
  n = (Math::sqrt(40*x+9) + 3)/10
  if nat_0(n) then n.to_i else nil end
end

def inv_octa(x)
  n = (Math::sqrt(3*x+1) + 1)/3
  if nat_0(n) then n.to_i else nil end
end

def tail(x)
  x[-2..-1]
end

def head(x)
  x[0..1]
end

##
# initial types.length should be > 1 :)
#
def search(nums, needed_types)
  if needed_types.length == 1
    new_num = tail(nums.last) + head(nums.first)
    if needed_types.last.call(new_num.to_i)
      yield nums + [new_num]
    end
    return
  end
  (
    if nums.empty?
      ("1000".."9999").to_a.select{|x| x[2] != "0"}
    else
      (tail(nums.last)+"10"..tail(nums.last)+"99")
    end
  ).each do |n|
    f = needed_types.select{|t| t.call(n.to_i)}
    if f.length == 1
      search(nums + [n], needed_types - f){|s| yield s}
    end
  end
end

if __FILE__ == $0
  #types = [
  #  method(:inv_tri),
  #  method(:inv_square),
  #  method(:inv_penta),
  #]
  types = [
    method(:inv_tri),
    method(:inv_square),
    method(:inv_penta),
    method(:inv_hexa),
    method(:inv_hepta),
    method(:inv_octa),
  ]
  search([], types) do |s|
    puts s.inspect
    puts s.map(&:to_i).inject(&:+)
    exit(0)
  end
end
