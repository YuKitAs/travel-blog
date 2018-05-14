require 'models/entity_with_representation'

class DummyClass
  include Mongoid::Document
  include EntityWithRepresentation
  field :dummy_field, type: String
end

RSpec.describe EntityWithRepresentation do
  before(:each) do
    @dummy_object = DummyClass.new
  end

  it 'gets representation' do
    expect(@dummy_object.representation).to include(:id, :dummy_field)
    expect(@dummy_object.representation).not_to include(:_id)
  end
end
