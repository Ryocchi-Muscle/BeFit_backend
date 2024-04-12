class Api::V1::TrainingSetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_training_menu, only: [:index, :create]
  before_action :set_training_set, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def create
    training_set = @training_menu.training_sets.new(training_set_params)
    if training_set.save
      render json: training_set, status: :created
    else
      render json: training_set.errors, status: :unprocessable_entity
    end
  end

  def update
    if @training_set.update(training_set_params)
      render json: @training_set
    else
      render json: @training_set.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @training_set.destroy
      head :no_content
    else
      render json: { error: "削除失敗" }, status: :unprocessable_entity
    end
  end

  def index
    render json: @training_menu.training_sets
  end

  def show
    render json: @training_set
  end

  private

    def set_training_menu
      @training_menu = TrainingMenu.find(params[:training_menu_id])
    end

    def set_training_set
      @training_set = TrainingSet.find(params[:id])
    end

    def training_set_params
      params.require(:training_set).permit(:set_number, :weight, :reps, :completed)
    end

    def record_not_found
      render json: { error: "レコードが見つからないよ" }, status: :not_found
    end
end
