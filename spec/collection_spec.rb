require 'spec_helper'

describe Collection do
  let(:items) { [Entity.new, Entity.new] }
  let(:coll) { Collection.new(items) }
  it 'can iterate' do
    a = []
    coll.each { |el| a << el }
    enum = coll.each
    expect(a).to match_array(items)
    expect(enum.next).to eq(items[0])
    expect(enum.next).to eq(items[1])
  end

  it 'can be inspected' do
    expect(coll.inspect).to eq('<Collection {:items=>[<Entity {:id=>nil, :x=>nil, :y=>nil}>, <Entity {:id=>nil, :x=>nil, :y=>nil}>]}>')
  end
end
