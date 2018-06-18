RSpec.describe Image, type: :model do
  it{should validate_presence_of(:content).with_message('cannot be empty')}

  it{should embed_one(:thumbnail)}
end
