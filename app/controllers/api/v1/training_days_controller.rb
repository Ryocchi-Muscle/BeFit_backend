class Api::V1::TrainingDaysController < ApplicationController
  def show
    training_day = TrainingDay.find(params[:id])
    render json: training_day
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Training day not found' }, status: :not_found
  end
end
