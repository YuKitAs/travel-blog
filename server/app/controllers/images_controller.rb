require 'mini_magick'

class ImagesController < ApplicationController
  def show
    send_data(found_entity[:content].data, type: 'image/jpeg', disposition: 'inline') if image_valid
  end

  def show_thumbnail
    image = MiniMagick::Image.read(found_entity[:content].data) if image_valid

    new_height = 300 * image.height / image.width
    image.resize("300x#{new_height}")

    send_data(File.open(image.path, 'rb'), type: 'image/jpeg', disposition: 'inline')
  end

  def create
    if params[:image].content_type != 'image/jpeg'
      render(status: :bad_request)
    else
      new_image = Image.new(content: BSON::Binary.new(params[:image].read))

      if new_image.save
        render(status: :created)
      else
        render(json: new_image.errors, status: :unprocessable_entity)
      end
    end
  end

  private

  def entity
    return Image
  end

  def image_valid
    found_entity.has_attribute?(:content) && found_entity[:content]
  end
end
