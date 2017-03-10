require_relative 'p02_hashing'

class HashSet

  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    self[key] << key
    self.count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](key)
    location = key.hash % num_buckets
    self.store[location]

    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_storage = Array.new(num_buckets * 2) { Array.new }

    store.each do |bucket|
      bucket.each do |key|
        new_location = key.hash % new_storage.count
        new_storage[new_location] << key
      end
    end

    self.store = new_storage
  end
end
