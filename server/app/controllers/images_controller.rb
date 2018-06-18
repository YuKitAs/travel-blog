class ImagesController < ApplicationController
  THUMBNAIL_WIDTH = 400
  DEFAULT_IMAGE_LIMIT = 20

  def index
    search_criteria = Image.all.order_by(:created_at.desc)
    search_criteria = search_criteria.skip(params[:start].to_i) if params[:start]
    search_criteria = if params[:limit] && params[:limit] <= DEFAULT_IMAGE_LIMIT
                        search_criteria.limit(params[:limit].to_i)
                      else
                        search_criteria.limit(DEFAULT_IMAGE_LIMIT)
                      end

    @images = search_criteria.to_a

    render(:images, status: :ok)
  end

  def show
    send_data(Image.find(params[:id])[:content].data, type: 'image/jpeg', disposition: 'inline')
  rescue Mongoid::Errors::DocumentNotFound
    raise(EntityNotFoundError, "Image #{params[:id]} cannot be found")
  end

  def show_thumbnail
    send_data(Image.find(params[:id])[:thumbnail][:content].data, type: 'image/jpeg', disposition: 'inline')
  rescue Mongoid::Errors::DocumentNotFound
    raise(EntityNotFoundError, "Image #{params[:id]} cannot be found")
  end

  def create
    if params[:image].content_type != 'image/jpeg'
      raise(InvalidDataError, 'The format of the image is incorrect')
    end

    image_content = BSON::Binary.new(params[:image].read)

    @image = Image.new(
      content: image_content,
      thumbnail: generate_thumbnail(MiniMagick::Image.read(image_content.data))
    )
    @image.save

    render(:image, status: :created)
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    render(:image, status: :ok)
  rescue Mongoid::Errors::DocumentNotFound
    raise(EntityNotFoundError, "Image #{params[:id]} cannot be found")
  end

  private

  def generate_thumbnail(image)
    thumbnail_height = THUMBNAIL_WIDTH * image.height / image.width
    image.resize("#{THUMBNAIL_WIDTH}x#{thumbnail_height}")

    return { width: THUMBNAIL_WIDTH, height: thumbnail_height, content: BSON::Binary.new(File.binread(image.path)) }
  end
end
