class MaxIntSet
  attr_accessor :set
  def initialize(max)
    @set = Array.new(max) {false}
  end

  def insert(num)
    validate!(num)
    set[num] = true
  end

  def remove(num)
    set[num] = false
  end

  def include?(num)
    set[num]
  end

  private

  def is_valid?(num)
    num < set.count && num > 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    location = num % store.count
    store[location]

    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if self.count >= num_buckets

    self[num] << num
    self.count += 1
  end

  def remove(num)
    self[num].delete(num)
    self.count -= 1
  end

  def include?(num)
    self[num].include?(num)

  end

  private

  def [](num)
    location = num % store.count
    store[location]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_storage = Array.new(num_buckets * 2) { Array.new }

    store.each do |bucket|
      bucket.each do |num|
        new_location = num % new_storage.count
        new_storage[new_location] << num
      end
    end

    self.store = new_storage
  end
end
