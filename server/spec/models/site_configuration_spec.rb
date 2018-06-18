RSpec.describe SiteConfiguration, type: :model do
  it{should validate_presence_of(:key).with_message('cannot be empty')}
  it{should validate_uniqueness_of(:key).with_message('must be unique')}

  it{should validate_presence_of(:value).with_message('cannot be empty')}
end
