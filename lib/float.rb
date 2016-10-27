# Additions to Float for conversion between various units.
class Float
  # Convert decimal degrees to radians. Input range is either -180.0 to 180.0
  # for longitudes, or -90.0 to 90.0 for latitudes.
  def to_radians(deg)
    deg * Math::PI / 180
  end

  # Convert radians to degrees. Return range is -180.0 to 180.0.
  def to_degrees(rad)
    rad * 180 / Math::PI
  end
end
