RSpec.describe Place, type: :model do
  it{should validate_presence_of(:name).with_message('cannot be empty')}
  it{should validate_uniqueness_of(:name).with_message('must be unique')}

  it{should validate_presence_of(:location).with_message('cannot be empty')}
end
