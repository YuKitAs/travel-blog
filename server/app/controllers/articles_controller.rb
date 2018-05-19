class ArticlesController < ApplicationController
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

  def index_preview
    start = params[:start].to_i || 0
    limit = params[:limit].to_i || (Article.all.length + 1)

    article_previews = []
    Article.desc(:date).skip(start).limit(limit).to_a.each do |article|
      thumbnail = Image.where('thumbnail._id' => article[:thumbnail_id]).first[:thumbnail]
      place = Place.where('_id' => article[:place_id]).first

      article_previews.push(
        id: article[:_id],
        thumbnail: {
          id: thumbnail[:_id],
          width: thumbnail[:width],
          height: thumbnail[:height]
        },
        title: article[:title],
        date: article[:date],
        place: {
          id: place[:_id],
          name: place[:name]
        },
        introduction: article[:introduction]
      )
    end

    render(json: article_previews)
  end

  private

  def entity
    return Article
  end

  def entity_field_params
    return params.require(:article).permit(:title, :introduction, :content, :date,
      :place_id, :thumbnail_id, tag_ids: [])
  end
end
