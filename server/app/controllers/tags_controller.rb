class TagsController < ApplicationController
  before_action :set_entity
  before_action :set_model, only: [:show, :update, :destroy]
  before_action :set_model_params, only: [:create, :update]

  def index
    if params[:article_id].nil?
      super
    else
      tag_representations = []
      tag_ids = Article.find(params[:article_id])[:tag_ids]

      tag_ids&.each do |id|
        unless (tag = Tag.find(id)).nil?
          tag_representations.push(tag.representation)
        end
      end

      render(json: tag_representations)
    end
  end

  private

  def set_entity
    self.entity = Tag
  end

  def set_model_params
    self.model_params = tag_params
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
