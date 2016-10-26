describe Rider do
  subject { described_class.new(id: 1, x: 1, y: 1, speed: 1) }
  it 'should have getters' do
    expect(subject.respond_to?(:id)).to eq(true)
    expect(subject.respond_to?(:x)).to eq(true)
    expect(subject.respond_to?(:y)).to eq(true)
    expect(subject.respond_to?(:speed)).to eq(true)
    expect(subject.respond_to?(:collection)).to eq(true)
  end

  it 'should have setters' do
    expect(subject.respond_to?(:id=)).to eq(true)
    expect(subject.respond_to?(:x=)).to eq(true)
    expect(subject.respond_to?(:y=)).to eq(true)
    expect(subject.respond_to?(:speed=)).to eq(true)
  end

  it 'should return values' do
    expect(subject.id).to eq(1)
    expect(subject.x).to eq(1)
    expect(subject.y).to eq(1)
    expect(subject.speed).to eq(1)
  end

  it 'should assign values' do
    subject.id = 2
    subject.x = 2
    subject.y = 2
    subject.speed = 2
    expect(subject.id).to eq(2)
    expect(subject.x).to eq(2)
    expect(subject.speed).to eq(2)
  end
end
