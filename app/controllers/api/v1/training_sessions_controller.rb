class Api::V1::TrainingSessionsController < ApplicationController
  before_action  :set_current_user, :set_training_session, only: [:show, :update]

  def show
         Rails.logger.debug("current_user: #{current_user}")
    render json: {
      training_session: @training_session,
      elapsed_days: @training_session.elapsed_days,
      remaining_days: @training_session.remaining_days
    }
  end

  def create
    @training_session = current_user.training_sessions.build(training_session_params)
    if @training_session.save
      render json: @training_session, status: :created
    else
      render json: @training_session.errors, status: :unprocessable_entity
    end
  end

  def update
    if @training_session.update(training_session_params)
      render json: @training_session
    else
      render json: @training_session.errors, status: :unprocessable_entity
    end
  end

  private

    def set_training_session
      unless current_user
        render json: { error: 'Unauthorized' }, status: :unauthorized
        return
      end

      @training_session = current_user.training_sessions.find(params[:id])
    end

    def training_session_params
      params.require(:training_session).permit(:start_date)
    end
end
