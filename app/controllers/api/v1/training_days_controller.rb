class Api::V1::TrainingDaysController < ApplicationController
  def index
    @training_days = current_user.training_days
    render json: @training_days
  end

  def show
    @training_days = current_user.training_days
    render json: @training_days
  end

  def create
    pp "current_user: #{current_user}"
    @training_day = current_user.training_days.build(training_day_params)
    if @training_day.save
      render json: @training_day, status: :created
    else
      render json: @training_day.errors, status: :unprocessable_entity
    end
  end

  private

    def training_day_params
      params.require(:training_day).permit(:date)
    end
end
