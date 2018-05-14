class ImagesController < ApplicationController
  def show
    render(json: Image.find(params[:id]).representation)
  end

  def create
    new_image = Image.new(content: BSON::Binary.new(params[:image].read))

    if new_image.save
      render(json: new_image.representation, status: :created)
    else
      render(json: new_image.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    Image.find(params[:id]).destroy
  end
end
