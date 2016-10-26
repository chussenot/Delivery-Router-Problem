class Foo
  include Point::InstanceMethods
  def initialize(attributes = nil)
    @x = attributes[:x]
    @y = attributes[:y]
  end
end

describe Foo do
  it 'can manage euclidean_distance' do
    a = Foo.new x: 1, y: 2
    b = Foo.new x: 1, y: 2
    expect(a.euclidean_distance(b)).to eq(0.0)
    expect(b.euclidean_distance(a)).to eq(0.0)
  end

  it 'can manage euclidean_distance' do
    a = Foo.new x: 1, y: 1
    b = Foo.new x: 0, y: 1
    expect(a.euclidean_distance(b)).to eq(1.0)
  end

  it 'can manage euclidean_distance' do
    a = Foo.new x: 1, y: 1
    b = Foo.new x: 2, y: 2
    c = Foo.new x: 1, y: 2
    d = Foo.new x: 2, y: 1
    expect(a.euclidean_distance(b)).to eq(c.euclidean_distance(d))
  end
end
