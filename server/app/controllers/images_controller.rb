class ImagesController < ApplicationController
  def show
    send_data(Image.find(params[:id])[:content].data, type: 'image/jpeg', disposition: 'inline')
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

  def destroy
    Image.find(params[:id]).destroy
  end
end
