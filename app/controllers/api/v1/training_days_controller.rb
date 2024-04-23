class Api::V1::TrainingDaysController < ApplicationController
  before_action :set_current_user, :set_training_day, only: [:show, :update, :destroy]

  def index
    @training_days = current_user.training_days
    render json: @training_days
  end

  def show
    render json: @training_days
  end

  def create
    Rails.logger.debug("current_user: #{current_user}")
    @training_day = current_user.training_days.build(training_day_params)
    if @training_day.save
      render json: @training_day, status: :created
    else
      render json: @training_day.errors, status: :unprocessable_entity
    end
  end

  def update
    if @training_day.update(training_day_params)
      render json: @training_day
    else
      render json: @training_day.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @training_day.destroy
    head :no_content
  end

  private

    def set_current_user
      @training_day = current_user.training_days.find(params[:id])
    end

    def training_day_params
      params.require(:training_day).permit(:date)
    end
end
