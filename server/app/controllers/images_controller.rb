require 'mini_magick'

class ImagesController < ApplicationController
  def show
    send_data(found_entity[:content].data, type: 'image/jpeg', disposition: 'inline') if image_valid?
  end

  def show_thumbnail
    send_data(found_entity[:thumbnail][:content].data, type: 'image/jpeg', disposition: 'inline') if thumbnail_valid?
  end

  def create
    if params[:image].content_type != 'image/jpeg'
      render(status: :bad_request)
    else
      image_content = BSON::Binary.new(params[:image].read)

      new_image = Image.new(content: image_content, thumbnail: resize(MiniMagick::Image.read(image_content.data)))

      if new_image.save
        render(json: { id: new_image[:id] }, status: :created)
      else
        render(json: new_image.errors, status: :unprocessable_entity)
      end
    end
  end

  private

  def entity
    return Image
  end

  def image_valid?
    found_entity[:content].present?
  end

  def thumbnail_valid?
    image_valid? && found_entity[:thumbnail].present?
  end

  def resize(image)
    thumbnail_height = 300 * image.height / image.width
    image.resize("300x#{thumbnail_height}")

    return { width: 300, height: thumbnail_height, content: BSON::Binary.new(File.binread(image.path)) }
  end
end
