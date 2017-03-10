class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = self.first
    self.each_with_index do |el, idx|
      next if idx == 0
      sum += el * (idx + 1)
    end
    sum.hash
  end
end

class String
  def hash
    alphabet = ("A".."Z").to_a + ("a".."z").to_a

    sum = 0
    self.chars.each_with_index do |char, idx|
      sum += alphabet.index(char) * (idx + 1)
    end

    sum.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    alphabet = ("A".."Z").to_a + ("a".."z").to_a

    sum = 0
    self.each do |key, val|
      if val.is_a?(Integer)
        sum += alphabet.index(key.to_s) * val
      else
        sum += alphabet.index(key.to_s) * alphabet.index(val.to_s)
      end
    end
    sum.hash
  end
end
