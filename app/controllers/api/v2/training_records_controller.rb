# app/controllers/api/v2/training_records_controller.rb
class Api::V2::TrainingRecordsController < ApplicationController
  before_action :set_current_user

  def show
    date = params[:id]
    training_day = TrainingDay.find_by(date: date, user_id: current_user.id)

    if training_day
      training_menus = training_day.training_menus.includes(:training_sets)
      render json: training_menus.as_json(include: { training_sets: { except: [:created_at, :updated_at] } }),
             status: :ok # 200
      Rails.logger.debug("training_menus: #{training_menus.inspect}")
    else
      render json: { status: 'error', message: 'Record not found' }, status: :not_found # 404
    end
  end

  def create
    Rails.logger.debug("Received params: #{params.inspect}")
    ActiveRecord::Base.transaction do
      training_day = TrainingDay.find_or_initialize_by(date: params[:date])
      begin
        Rails.logger.debug("training_day: #{training_day.inspect}")
        training_day.user_id = current_user.id if current_user
        training_day.save!
      rescue StandardError => e
        Rails.logger.error("An error occurred: #{e.message}")
        render json: { status: 'error', message: e.message }, status: :internal_server_error # 500
      end

      params[:menus].each do |menu|
        training_menu = training_day.training_menus.find_or_initialize_by(exercise_name: menu[:menuName])
        Rails.logger.debug("training_day: #{training_day.inspect}")
        menu[:sets].each do |set|
          training_set = training_menu.training_sets.find_or_initialize_by(set_number: set[:setId])
          training_set.update(weight: set[:weight], reps: set[:reps], completed: set[:completed])
          Rails.logger.debug("training_set: #{training_set.inspect}")
          Rails.logger.debug("training_set.attributes: #{training_set.attributes}")
          training_set.save!
        end
        Rails.logger.debug("training_menu: #{training_menu.inspect}")
        training_menu.save!
      end

      render json: { status: 'success' }
    rescue ActiveRecord::RecordInvalid => e
      render json: { status: 'error', errors: e.record.errors.full_messages }, status: :unprocessable_entity # 422
      raise ActiveRecord::Rollback
    end
  end

  # rescue StandardError => e
  #   render json: { status: 'error', message: e.message }, status: :internal_server_error # 500
  # end

  private

    def training_day_params
      params.require(:training_day).permit(:date, menus: [:menuId, :menuName, { sets: [:setId, :weight, :reps, :completed] }])
    end
end
