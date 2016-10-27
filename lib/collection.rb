class Collection
  include Enumerable

  class << self
    def [](*args)
      new(args)
    end
  end

  def initialize(*args)
    @items = args.flatten
    tap do |me|
      @items.each { |l| l.collection = me }
    end
  end

  def find_by_id(id)
    return if id.nil?
    o = nil
    @items.each do |i|
      if i.to_h.merge(id: id) == i.to_h
        o = i
        break
      end
    end
    o
  end

  def each
    if block_given?
      @items.each { |l| yield l }
    else
      @items.to_enum(:each)
    end
  end

  def to_array
    @items.map(&:to_a)
  end

  def inspect
    "<#{self.class} #{{ items: @items }}>"
  end

  alias to_a to_array
end
