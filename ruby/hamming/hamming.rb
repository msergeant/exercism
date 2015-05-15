class Hamming
  def self.compute(a ,b)
    (0...a.length).count do |index|
      a[index] != b[index]
    end
  end
end
