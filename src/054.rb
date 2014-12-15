#
# $File$
# $Author$
# $Date$
# $Revision$
#

$val_map = {:T => 10, :J => 11, :Q => 12, :K => 13, :A => 14}

class Card
  attr_reader :suit, :val

  def initialize(v, s)
    @val = v
    @suit = s
  end

  def to_s
    ($val_map.invert[@val] || @val).to_s + @suit
  end
end

def str2card(s)
  v, s = *(s.strip.split(""))
  v = $val_map[v.upcase.to_sym] || v.to_i
  s = s.upcase
  Card.new(v, s)
end

$rank_map = {
  :straight_flush => 9,
  :four_of_a_kind => 8,
  :full_house => 7,
  :flush => 6,
  :straight => 5,
  :three_of_a_kind => 4,
  :two_pairs => 3,
  :one_pair => 2,
  :high_card => 1
}

def rank(hand)
  vals = hand.map(&:val).sort.reverse
  flush = (hand.map(&:suit).uniq.length == 1)
  return \
    straight_flush(vals, flush) ||
    four_of_a_kind(vals) ||
    full_house(vals) ||
    flush(vals, flush) ||
    straight(vals) ||
    three_of_a_kind(vals) ||
    two_pairs(vals) ||
    one_pair(vals) ||
    [$rank_map[:high_card]] + vals
end

def straight_flush(vals, flush)
  if flush and vals == (vals.min..vals.max).to_a.reverse
    return [$rank_map[:straight_flush],vals.max]
  end
  nil
end

def four_of_a_kind(vals)
  if vals.uniq.length == 2 and vals.count(vals.min) == 4
    return [$rank_map[:four_of_a_kind], vals.min, vals.max]
  elsif vals.uniq.length == 2 and vals.count(vals.max) == 4
    return [$rank_map[:four_of_a_kind], vals.max, vals.min]
  end
  nil
end

def full_house(vals)
  if vals.uniq.length == 2 and vals.count(vals.min) == 3
    return [$rank_map[:full_house], vals.min, vals.max]
  elsif vals.uniq.length == 2 and vals.count(vals.max) == 3
    return [$rank_map[:full_house], vals.max, vals.min]
  end
  nil
end

def flush(vals, flush)
  if flush
    return [$rank_map[:flush]] + vals
  end
  nil
end

def straight(vals)
  if vals == (vals.min..vals.max).to_a.reverse
    return [$rank_map[:straight]] + vals
  end
  nil
end

def three_of_a_kind(vals)
  if v = vals.find{|x| vals.count(x) == 3}
    return [$rank_map[:three_of_a_kind]] + [v] + (vals - [v])
  end
  nil
end

def two_pairs(vals)
  if v = vals.find{|x| vals.count(x) == 2} and
     u = (vals - [v]).find{|x| vals.count(x) == 2}
      return [$rank_map[:two_pairs]] + [v,u].sort.reverse + (vals - [v,u])
  end
  nil
end

def one_pair(vals)
  if v = vals.find{|x| vals.count(x) == 2}
    return [$rank_map[:one_pair]] + [v] + (vals - [v])
  end
  nil
end

def wins(x,y)
  if x.empty? and y.empty?
    false
  elsif x[0] > y[0]
    true
  elsif x[0] < y[0]
    false
  else
    wins(x[1..-1], y[1..-1])
  end
end

count = 0
ARGF.each_line do |line|
  puts line
  cards = line.strip.split.map{|x| str2card(x)}
  r1, r2 = rank(cards[0..4]), rank(cards[5..10])
  count +=1 if wins(r1, r2)
  puts [
    " "*2,
    wins(r1, r2),
    ":",
    $rank_map.invert[r1[0]].to_s,
    r1[1..-1].join(" "),
    $rank_map.invert[r2[0]].to_s,
    r2[1..-1].join(" "),
  ].join(" ")
end
puts count

