class ArticlesController < ApplicationController
  before_action :set_entity
  before_action :set_model, only: [:show, :update, :destroy]
  before_action :set_model_params, only: [:create, :update]

  def index
    if params[:tag_id].nil?
      super
    else
      article_representations = []
      Article.all.each do |article|
        article_representations.push(article.representation) if article[:tag_ids].include?(params[:tag_id])
      end

      render(json: article_representations)
    end
  end

  private

  def set_entity
    self.entity = Article
  end

  def set_model_params
    self.model_params = article_params
  end

  def article_params
    params.require(:article).permit(:title, :content, :date, :place_id, :thumbnail_id, tag_ids: [])
  end
end
