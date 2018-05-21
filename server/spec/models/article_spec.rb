RSpec.describe Article, type: :model do
  it{should validate_presence_of(:title)}
  it{should validate_presence_of(:date)}
  it{should validate_presence_of(:introduction)}
  it{should validate_presence_of(:content)}
  it{should validate_presence_of(:place_id)}
  it{should validate_presence_of(:thumbnail_id)}
end
