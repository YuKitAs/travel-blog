class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :destroy]

  def show
    render(json: image_representation)
  end

  def create
    @image = Image.new(_id: SecureRandom.uuid, content: BSON::Binary.new(params[:image].read))

    if @image.save
      render(json: image_representation, status: :created)
    else
      render(json: @image.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @image.destroy
  end

  private

  def set_image
    @image = Image.find(params[:id])
  end

  def image_representation
    return { id: @image[:_id], content: Base64.encode64(@image[:content].data) }
  end
end
