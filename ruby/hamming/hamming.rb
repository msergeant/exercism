class Hamming
  def self.compute(a ,b)
    0.upto(a.length - 1).count do |index|
      a[index] != b[index]
    end
  end
end
