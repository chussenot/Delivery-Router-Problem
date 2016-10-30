class Foo < Entity
end

describe Foo do
  it 'can manage euclidean_distance' do
    a = Foo.new x: 1, y: 2
    b = Foo.new x: 1, y: 2
    expect(a.distance(b)).to eq(0.0)
    expect(b.distance(a)).to eq(0.0)
  end

  it 'can manage euclidean_distance' do
    a = Foo.new x: 1, y: 1
    b = Foo.new x: 0, y: 1
    expect(a.distance(b)).to eq(1.0)
  end

  it 'can manage euclidean_distance' do
    a = Foo.new x: 1, y: 1
    b = Foo.new x: 2, y: 2
    c = Foo.new x: 1, y: 2
    d = Foo.new x: 2, y: 1
    expect(a.distance(b)).to eq(c.distance(d))
  end

  it 'should calculate the geodesic distance in meters using Haversine formula' do
    a = Foo.new lat: 50.0359, lng: -0.054253
    b = Foo.new lat: 58.3838, lng: -0.030412
    expect(a.distance(b, :geodesic).round(0)).to eq 928_245
  end
end
