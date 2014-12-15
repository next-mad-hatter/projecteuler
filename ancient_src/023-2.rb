MAX = 28123

all = 1.upto(MAX).to_a

abu = []
File.open("ABU").each do |l|
  abu << l.strip.to_i
end

summed = []
0.upto(abu.length-1) do |i|
  break if abu[i] > MAX / 2.0
  i.upto(abu.length-1) do |j|
    break if abu[i] + abu[j] > MAX
    summed << (abu[i] + abu[j])
  end
end

summed = summed.sort.uniq
puts summed.length
puts summed[0]
puts summed[-1]
puts summed.inject(0){|x,y| x + y}
