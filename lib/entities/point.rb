module Point
  # Allows an object to be positioned on a plane.
  module InstanceMethods
    attr_accessor :x, :y

    def distance(other, geometry = :euclidean)
      send(geometry, other)
    end

    def to_array
      [x, y]
    end

    alias to_a to_array
    alias lat x
    alias lng y
    alias lat= x=
    alias lng= y=

    private

    def euclidean(other)
      Geo.euclidean_distance(Array(self), Array(other))
    end

    def geodesic(other)
      Geo.geodesic_distance(Array(self), Array(other))
    end
  end
end
