describe Order do
  subject { described_class.new(customer: 1, restaurant: 1) }
  it 'should have getters' do
    expect(subject.respond_to?(:customer)).to eq(true)
    expect(subject.respond_to?(:restaurant)).to eq(true)
    expect(subject.respond_to?(:collection)).to eq(true)
  end

  it 'should have setters' do
    expect(subject.respond_to?(:customer=)).to eq(true)
    expect(subject.respond_to?(:restaurant=)).to eq(true)
  end

  it 'should return values' do
    expect(subject.customer).to eq(1)
    expect(subject.restaurant).to eq(1)
  end

  it 'should assign values' do
    subject.customer = 2
    subject.restaurant = 2
    expect(subject.customer).to eq(2)
    expect(subject.restaurant).to eq(2)
  end
end
