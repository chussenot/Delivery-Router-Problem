describe Order do
  let(:customer) { Customer.new id: 1 }
  let(:restaurant) { Restaurant.new id: 1 }
  subject { described_class.new(customer: customer, restaurant: restaurant) }
  it 'should have getters' do
    expect(subject.respond_to?(:customer)).to eq(true)
    expect(subject.respond_to?(:restaurant)).to eq(true)
  end

  it 'should have setters' do
    expect(subject.respond_to?(:customer=)).to eq(true)
    expect(subject.respond_to?(:restaurant=)).to eq(true)
  end

  it 'should return values' do
    expect(subject.customer.id).to eq(1)
    expect(subject.restaurant.id).to eq(1)
  end

  it 'should assign values' do
    subject.customer = nil
    subject.restaurant = nil
    expect(subject.customer).to eq(nil)
    expect(subject.restaurant).to eq(nil)
  end
end
