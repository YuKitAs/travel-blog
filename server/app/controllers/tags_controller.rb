class TagsController < ApplicationController
  before_action :set_entity
  before_action :set_model, only: [:show, :update, :destroy]
  before_action :set_model_params, only: [:create, :update]

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
