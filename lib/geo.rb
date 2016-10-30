module Geo
  # Earth's radius in kilometers
  EARTH_RADIUS = 6371.0

  class << self
    def euclidean_distance(a, b)
      s = 0
      a.zip(b).each do |v1, v2|
        c = (v1 - v2)**2
        s += c
      end
      Math.sqrt(s)
    end

    def geodesic_distance(a, b)
      dlat = (b[0] - a[0]).to_radians
      dlon = (b[1] - a[1]).to_radians
      d = Math.sin(dlat / 2) * Math.sin(dlat / 2) +
          Math.cos(a[0].to_radians) * Math.cos(b[0].to_radians) *
          Math.sin(dlon / 2) * Math.sin(dlon / 2)
      c = 2 * Math.atan2(Math.sqrt(d), Math.sqrt(1 - d))
      EARTH_RADIUS * c * 1000
    end
  end
end
