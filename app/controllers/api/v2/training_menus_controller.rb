class Api::V2::TrainingMenusController < ApplicationController
  before_action :set_current_user
  def index
    @training_menus = current_user.where(user_id: params[:user_id], date: params[:date])
    render json: @training_menus
  end
end
