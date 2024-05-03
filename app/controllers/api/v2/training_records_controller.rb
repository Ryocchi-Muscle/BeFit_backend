# app/controllers/api/v2/training_records_controller.rb
class Api::V2::TrainingRecordsController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      training_day = TrainingDay.find_or_initialize_by(date: params[:date])
      Rails.logger.debug("training_day: #{training_day.inspect}")
      params[:menus].each do |menu|
        Rails.logger.debug("menu: #{menu.inspect}")
        training_menu = training_day.training_menus.find_or_initialize_by(exercise_name: menu[:menuName])
        Rails.logger.debug("training_menu: #{training_menu.inspect}")
        menu[:sets].each do |set|
          training_set = training_menu.training_sets.find_or_initialize_by(set_number: set[:setId])
          training_set.update(weight: set[:weight], reps: set[:reps], completed: set[:completed])
        end
        training_menu.save!
      end
      training_day.save!
    end
    render json: { status: 'success' }
  rescue StandardError => e
    render json: { status: 'error', message: e.message }
  end

  private

    def training_day_params
      params.require(:training_day).permit(:date, menus: [:menuId, :munuName, { sets: [:setId, :weight, :reps, :completed] }])
    end
end

# # current_user.training_sessions.new!(start_date: Date.today)
