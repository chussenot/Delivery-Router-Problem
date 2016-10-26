module Point
  module InstanceMethods
    attr_accessor :x, :y

    def euclidean_distance(other)
      s = 0
      Array(self).zip(other.to_a).each do |v1, v2|
        c = (v1 - v2)**2
        s += c
      end
      Math.sqrt(s)
    end

    def to_array
      [x, y]
    end

    alias to_a to_array
  end
end
