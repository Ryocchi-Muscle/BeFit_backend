class Api::V1::TrainingMenusController < ApplicationController
  # 特定のトレーニング日に新しいトレーニングメニューを追加
  def create
    training_day = TrainingDay.find(params[:training_day_id])
    training_menu = training_day.training_menus.new(training_menu_params)

    if training_menu.save
      render json: training_menu, status: :created
    else
      render json: training_menu.errors, status: :unprocessable_entity
    end
  end

  # 指定されたトレーニングメニューの情報を更新
  def update
    training_menu = TrainingMenu.find(params[:id])

    if training_menu.update(training_menu_params)
      render json: training_menu
    else
      render json: training_menu.errors, status: :unprocessable_entity
    end
  end

  # 指定されたトレーニングメニューを削除
  def destroy
    training_menu = TrainingMenu.find(params[:id])
    training_menu.destroy
    head :no_content
  end

  # 特定のトレーニング日に紐づく全てのトレーニングメニューを一覧表示
  def index
    training_day = TrainingDay.find(params[:training_day_id])
    training_menus = training_day.training_menus
    render json: training_menus
  end

  # 特定のトレーニングメニューの詳細情報を表示
  def show
    training_menu = TrainingMenu.find(params[:id])
    render json: training_menu
  end

  private

    def training_menu_params
      params.require(:training_menu).permit(
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
