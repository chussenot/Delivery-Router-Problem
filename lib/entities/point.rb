module Point
  module InstanceMethods
    attr_accessor :x, :y
    # Earth's radius in kilometers
    EARTH_RADIUS = 6371.0

    def distance(other, geometry = :euclidean)
      case geometry
      when :euclidean
        s = 0
        Array(self).zip(other.to_a).each do |v1, v2|
          c = (v1 - v2)**2
          s += c
        end
        Math.sqrt(s)
      when :geodesic
        dlat = (other.lat - lat).to_radians
        dlon = (other.lng - lng).to_radians
        a = Math.sin(dlat / 2) * Math.sin(dlat / 2) +
            Math.cos(lat.to_radians) * Math.cos(other.lat.to_radians) *
            Math.sin(dlon / 2) * Math.sin(dlon / 2)
        c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
        EARTH_RADIUS * c * 1000
      end
    end

    def to_array
      [x, y]
    end

    alias to_a to_array
    alias lat x
    alias lng y
  end
end
