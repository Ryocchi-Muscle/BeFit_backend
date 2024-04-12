class Api::V1::TrainingSetsController < ApplicationController
  def create
    training_menu = TrainingMenu.find(params[:training_menu_id])
    training_set = training_menu.training_sets.new(training_set_params)

    if training_set.save
      render json: training_set, status: :created
    else
      render json: training_set.errors, status: :unprocessable_entity
    end
  end

  def update
    training_set = TrainingSet.find(params[:id])

    if training_set.update(training_set_params)
      render json: training_set
    else
      render json: training_set.errors, status: :unprocessable_entity
    end
  end

  def destroy
    training_set = TrainingSet.find(params[:id])
    training_set.destroy
    head :no_content
  end

  def index
    training_menu = trainingMenu.find(params[:training_menu_id])
    training_sets = training_menu.training_sets
    render json: training_sets
  end

  def show
    training_set = TrainingSet.find(params[:id])
    render json: training_set
  end

  private

    def training_set_params
      params.require(:training_set).permit(:set_number, :weight, :reps, :completed)
    end
end
