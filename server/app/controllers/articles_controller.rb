class ArticlesController < ApplicationController
  before_action :set_entity
  before_action :set_model, only: [:show, :update, :destroy]
  before_action :set_model_params, only: [:create, :update]

  private

  def set_entity
    self.entity = Article
  end

  def set_model_params
    self.model_params = article_params
  end

  def article_params
    params.require(:article).permit(:title, :content, :date, :place_id, tag_ids: [])
  end
end
