class Hamming
  def self.compute(a ,b)
    sum = 0
    0.upto(a.length - 1) do |index|
      sum += 1 if (a[index] != b[index])
    end

    sum
  end
end
