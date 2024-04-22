class TrainingSessionsController < ApplicationController
  before_action :set_training_session, only: [:show, :update]

  def show
    training_session = TrainingSession.find(params[:id])
    render json: {
      training_session: training_session,
      elapsed_days: training_session.elapsed_days,
      remaining_days: training_session.remaining_days
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
      @training_session = current_user.training_sessions.find(params[:id])
    end

    def training_session_params
      params.require(:training_session).permit(:start_date)
    end
end
