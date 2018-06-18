RSpec.describe Thumbnail, type: :model do
  it{should validate_presence_of(:content).with_message('cannot be empty')}

  it{should validate_presence_of(:width).with_message('cannot be empty')}
  it{should allow_value(1).for(:width)}
  it{should_not allow_value(1.5).for(:width)}
  it{should_not allow_value(0).for(:width)}

  it{should validate_presence_of(:height).with_message('cannot be empty')}
  it{should allow_value(1).for(:height)}
  it{should_not allow_value(1.5).for(:height)}
  it{should_not allow_value(0).for(:height)}

  it{should be_embedded_in(:image)}
end
