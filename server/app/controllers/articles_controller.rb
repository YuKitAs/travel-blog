require 'securerandom'

class ArticlesController < ApplicationController
  def index
    article_models = Article.all
    article_representations = []
    article_models.each do |article_model|
      article_representations.push(article_model.representation)
    end
    render(json: article_representations)
  end

  def show
    article_model = Article.find(params[:id])
    render(json: article_model.representation)
  end

  def create
    article_model = Article.new(article_params.merge(_id: SecureRandom.uuid))
    article_model.save!
    render(json: article_model.representation)
  end

  def update
    article_model = Article.find(params[:id])
    article_model.update(article_params)
  end

  def destroy
    article_model = Article.find(params[:id])
    article_model.destroy
  end

  private

  def article_params
    params[:article][:place] = params[:place]
    params[:article][:place][:_id] = SecureRandom.uuid
    params.require(:article).permit(:title, :content, :date, place: [:_id, :name, location: [:lat, :long]])
  end
end
