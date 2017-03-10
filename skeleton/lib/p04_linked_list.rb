

class Link

  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  attr_accessor :head, :tail
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end


  def []=(i, mark)
    each_with_index { |link, j| link.val = mark if i == j }
    nil
  end

  def first
    self.head.next
  end

  def last
    self.tail.prev
  end

  def last=(link)
    self.tail.prev = link
  end

  def empty?
     first == tail && last == head
  end

  def get(key)
    index = find_index { |link| link.key == key }
    return self[index].val if self[index]
    nil
  end

  def include?(key)
    index = find_index { |link| link.key == key }
    return true if self[index]
    false
  end

  def append(key, val)
    new_element = Link.new(key, val)

    last.next = new_element
    new_element.prev = last
    self.last = new_element
    new_element.next = self.tail
  end

  def update(key, val)
    index = find_index { |link| link.key == key }
    self[index] = val
  end

  def remove(key)
    index = find_index { |link| link.key == key }

    current_el = self[index]

    previous_el = current_el.prev
    next_el = current_el.next

    previous_el.next = next_el
    next_el.prev = previous_el

  end

  # def my_find_index(&prc)
  #   index = nil
  #   i = 0
  #   self.each do |link|
  #     if prc.call(link)
  #       #need to update index
  #       index = i
  #     end
  #     i += 1
  #   end
  #   index
  # end

  def each(&prc)
    link = first
    until link == self.tail
      prc.call(link)
      link = link.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
