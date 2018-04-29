require_relative '../utils/fixture_reader'

RSpec.describe ArticlesController, type: 'controller' do
  before :each do
    @articles = read_json('articles.json')
    @article = @articles['article']
    @new_article = @articles['new_article']

    @article_id = Article.create!(@article).to_param
  end

  describe 'GET #index' do
    context 'without tag' do
      it 'lists all articles' do
        get :index
        articles = JSON.parse(response.body)
        article = articles.first

        expect(response.message).to eq 'OK'

        expect(articles.size).to be 1

        expect(article['title']).to eq @article['title']
        expect(article['content']).to eq @article['content']
        expect(article['date']).to eq @article['date']
        expect(article['place_id']).to eq @article['place_id']
        expect(article['tag_ids']).to eq @article['tag_ids']
        expect(article['thumbnail_id']).to eq @article['thumbnail_id']
      end
    end

    context 'with tag' do
      it 'lists all articles of a tag by tag id' do
        Article.create!(@new_article)
        get :index, params: { tag_id: @new_article['tag_ids'][1] }
        articles = JSON.parse(response.body)
        article = articles.first

        expect(response.message).to eq 'OK'

        expect(articles.size).to be 1

        expect(article['title']).to eq @new_article['title']
        expect(article['content']).to eq @new_article['content']
        expect(article['date']).to eq @new_article['date']
        expect(article['place_id']).to eq @new_article['place_id']
        expect(article['thumbnail_id']).to eq @new_article['thumbnail_id']
      end
    end
  end

  describe 'GET #show' do
    it 'shows a single article by id' do
      get :show, params: { id: @article_id }
      article = JSON.parse(response.body)

      expect(response.message).to eq 'OK'

      expect(article['title']).to eq @article['title']
      expect(article['content']).to eq @article['content']
      expect(article['date']).to eq @article['date']
      expect(article['place_id']).to eq @article['place_id']
      expect(article['tag_ids']).to eq @article['tag_ids']
      expect(article['thumbnail_id']).to eq @article['thumbnail_id']
    end
  end

  describe 'POST #create' do
    context 'with authorization' do
      it 'creates a new article' do
        login

        post :create, params: { article: @new_article }
        new_article = JSON.parse(response.body)

        expect(response.message).to eq 'Created'

        expect(Article.all.size). to be 2

        expect(new_article['title']).to eq @new_article['title']
        expect(new_article['content']).to eq @new_article['content']
        expect(new_article['date']).to eq @new_article['date']
        expect(new_article['place_id']).to eq @new_article['place_id']
        expect(new_article['tag_ids']).to eq @new_article['tag_ids']
        expect(new_article['thumbnail_id']).to eq @new_article['thumbnail_id']
      end
    end

    context 'without authorization' do
      it 'does not create article' do
        post :create, params: { article: @new_article }

        expect(response.message).to eq 'Unauthorized'
      end
    end
  end

  describe 'PUT #update' do
    context 'with authorization' do
      it 'updates a new article' do
        login

        put :update, params: { id: @article_id, article: @new_article }
        article = Article.find(@article_id)

        expect(article['title']).to eq @new_article['title']
        expect(article['content']).to eq @new_article['content']
        expect(article['date']).to eq @new_article['date']
        expect(article['place_id']).to eq @new_article['place_id']
        expect(article['tag_ids']).to eq @new_article['tag_ids']
        expect(article['thumbnail_id']).to eq @new_article['thumbnail_id']
      end
    end

    context 'without authorization' do
      it 'does not update article' do
        put :update, params: { id: @article_id, article: @new_article }

        expect(response.message).to eq 'Unauthorized'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with authorization' do
      it 'deletes an article by id' do
        login

        delete :destroy, params: { id: @article_id }

        expect(Article.all).to be_empty
      end
    end

    context 'without authorization' do
      it 'does not delete article' do
        delete :destroy, params: { id: @article_id }

        expect(response.message).to eq 'Unauthorized'

        expect(Article.find(@article_id)).to be_truthy
      end
    end
  end
end

private

def login
  allow(AuthorizeApiRequest).to receive_message_chain(:call, :result){:user}
end
