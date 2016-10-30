require 'spec_helper'

module Inspect
  def inspect
    "<#{self.class.to_s.split('::').last} @model=#{@model}>"
  end
  alias to_s inspect
end

class OtherOperation < Operation
  include Inspect

  def process(params)
    @model = params
  end

  def setup_params!(params)
    params.merge!(baatch: 'Rocks!')
  end
end

describe Operation do
  it 'should implement class methods' do
    expect(described_class.respond_to?(:[])).to eq(true)
    expect(described_class.respond_to?(:run)).to eq(true)
    expect(described_class.respond_to?(:call)).to eq(true)
  end

  it 'should return a result' do
    res, op = SimpleOperation.run(name: 'Jon')
    expect(res).to eq(false)
    expect(op).to eq('Jon')
  end

  it 'can setup params' do
    str = OtherOperation.run(name: 'Jon').to_s
    expect(str).to eq('[true, {:name=>"Jon", :baatch=>"Rocks!"}]')
  end

  it 'can be call()' do
    expect(OtherOperation.call(name: 'Jon')).to eq(name: 'Jon', baatch: 'Rocks!')
  end

  it 'can be run with a block' do
    op = SimpleOperation.run(name: 'Jon') do |op|
    end
    expect(op).to eq('Jon')
  end
end
