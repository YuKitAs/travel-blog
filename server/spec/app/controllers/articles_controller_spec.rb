require_relative '../../utils/fixture_reader'
require 'controllers/articles_controller'
require 'json'

RSpec.describe ArticlesController, type: 'controller' do
  before :each do
    @articles = read_fixture('articles.json')
  end

  it 'lists all articles' do
    puts @articles['title']
  end
end
