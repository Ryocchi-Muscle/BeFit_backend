class Api::V1::TrainingMenusController < ApplicationController
  def create; end

  private

    def set_training_day
      @training_day = TrainingDay.find(params[:training_day_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Training day not found' }, status: :not_found
    end

    def training_menu_params
      params.require(:training_mueu).permit(
        :body_part,
        :exercise_name,
        sets_attributes: [
          :weight,
          :reps,
          :completed
        ]
      )
    end
end
