require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap

  include Enumerable

  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
  end

  def set(key, val)
    resize! if self.count == num_buckets
    if bucket(key).get(key)
      bucket(key).update(key,val)
    else
      bucket(key).append(key,val)
      self.count += 1
    end
  end

  def get(key)
    bucket_we_want = bucket(key)
    bucket_we_want.get(key)
  end

  def delete(key)
    bucket_we_want = bucket(key)
    bucket_we_want.remove(key)
    self.count -= 1
  end

  def each(&prc)
    self.store.each do |bucket|
      bucket.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end


  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_storage = Array.new(num_buckets * 2) { LinkedList.new }

    self.each do |k, v|
      bucket_index = k.hash % new_storage.count
      new_storage[bucket_index].append(k, v)
    end

    self.store = new_storage
  end

  def bucket(key)
    store[key.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
