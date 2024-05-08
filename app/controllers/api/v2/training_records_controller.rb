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
    ActiveRecord::Base.transaction do
      training_day = TrainingDay.find_or_initialize_by(date: params[:date], user_id: current_user.id)
      training_day.save!

      # 存在するメニューIDを取得
      existing_menus_ids = training_day.training_menus.pluck(:id)
      Rails.logger.debug("existing_menus_ids: #{existing_menus_ids}")
      client_menu_ids = params[:menus].map { |menu| menu[:menuId] }
      Rails.logger.debug("client_menu_ids: #{client_menu_ids}")

      training_day.training_menus.where(id: existing_menus_ids - client_menu_ids).destroy_all

      params[:menus].each do |menu|
        training_menu = training_day.training_menus.find_or_initialize_by(exercise_name: menu[:menuName])
        Rails.logger.debug("training_menu: #{training_menu.inspect}")
        training_menu.update(exercise_name: menu[:menuName])

        # 存在するセットIDを取得
        existing_sets = training_menu.training_sets.pluck(:id)
        client_set_ids = menu[:sets].map { |set| set[:setId] }

        training_menu.training_sets.where(id: existing_sets - client_set_ids).destroy_all

        menu[:sets].each do |set|
          training_set = training_menu.training_sets.find_or_initialize_by(set_number: set[:setNumber])
          training_set.update(set_number: set[:setNumber], weight: set[:weight], reps: set[:reps], completed: set[:completed])
          training_set.save!
        end
        training_menu.save!
      end

      render json: { status: 'success' }
    rescue ActiveRecord::RecordInvalid => e
      render json: { status: 'error', errors: e.record.errors.full_messages }, status: :unprocessable_entity # 422
      raise ActiveRecord::Rollback
    end
  end

  def weekly_summary
    start_date = params[:date].to_date.beginning_of_week(:sunday)
    end_date = start_date.end_of_week(:sunday)

    current_week_weight = TrainingDay.where(date: start_date...end_date, user_id: current_user.id).joins(training_menus: :training_sets).sum(
      'training_sets.weight * training_sets.reps'
    )

    render json: { week_start: start_date, total_weight: current_week_weight }
  end

  private

    def training_day_params
      params.require(:training_day).permit(:date, menus: [:menuId, :menuName, { sets: [:setId, :weight, :reps, :completed] }])
    end
end
