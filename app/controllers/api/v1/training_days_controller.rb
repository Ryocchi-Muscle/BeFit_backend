class Api::V1::TrainingDaysController < ApplicationController
 def index
  @training_days = current_user.training_days
  render json: @training_days
 end

 def show
  @training_days = current_user.training_days
 end
end
