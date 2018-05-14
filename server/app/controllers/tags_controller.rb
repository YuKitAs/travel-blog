class TagsController < ApplicationController
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

  def entity
    return Tag
  end

  def entity_field_params
    return params.require(:tag).permit(:name)
  end
end
