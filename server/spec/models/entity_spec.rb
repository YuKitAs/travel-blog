require 'models/entity'

class DummyClass
  include Mongoid::Document
  field :dummy_field, type: String
end

RSpec.describe Entity do
  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(Entity)
  end

  it 'gets representation' do
    expect(@dummy_class.representation).to include(:id, :dummy_field)
  end
end
