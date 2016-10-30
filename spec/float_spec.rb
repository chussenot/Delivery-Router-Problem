require 'spec_helper'

describe Float do
  let(:f) { 1.3 }
  it 'can be converted to radians or degrees' do
    expect(f.to_radians.round(3)).to eq(0.023)
    expect(f.to_degrees.round(3)).to eq(74.485)
  end
end
