RSpec.describe Article, type: :model do
  it{should validate_presence_of(:title).with_message('cannot be empty')}

  it{should validate_presence_of(:date).with_message('cannot be empty')}
  it{should allow_value('2018-10-31').for(:date)}
  it{should_not allow_value('invalid_date').for(:date)}

  it{should validate_presence_of(:introduction).with_message('cannot be empty')}

  it{should validate_presence_of(:content).with_message('cannot be empty')}

  it{should validate_presence_of(:place_id).with_message('cannot be empty')}
  it{should allow_value('00000000-0000-0000-0000-000000000000').for(:place_id)}
  it{should_not allow_value('invalid_uuid').for(:place_id)}

  it{should allow_value(['00000000-0000-0000-0000-000000000000']).for(:tag_ids)}
  it{should allow_value([]).for(:tag_ids)}
  it{should_not allow_value(['invalid_uuid']).for(:tag_ids)}

  it{should validate_presence_of(:thumbnail_id).with_message('cannot be empty')}
  it{should allow_value('00000000-0000-0000-0000-000000000000').for(:thumbnail_id)}
  it{should_not allow_value('invalid_uuid').for(:thumbnail_id)}
end
