class Api::V2::TrainingRecordsController < ApplicationController
  before_action :set_current_user

  def index
    training_days = TrainingDay.where(user_id: current_user.id).order(:date)
    render json: training_days, each_serializer: TrainingDaySerializer
  end

  def show
    date = params[:id]
    training_day = TrainingDay.find_by(date: date, user_id: current_user.id)

    if training_day
      training_menus = training_day.training_menus.includes(:training_sets)
      Rails.logger.debug "Retrieved training_menus: #{training_menus.as_json(include: { training_sets: { except: [:created_at, :updated_at] } })}"
        # 各 training_menu の exercise_name をデバッグ出力
      training_menus.each do |menu|
        Rails.logger.debug "TrainingMenu: #{menu.exercise_name}"
      end

      render json: training_menus, each_serializer: TrainingMenuSerializer, status: :ok # 200
    else
      render json: { status: 'error', message: 'Record not found' }, status: :not_found # 404
    end
  end

  # 完了ボタンを押したときの処理
  def update
    Rails.logger.debug("params: #{params.inspect}")

    ActiveRecord::Base.transaction do
      # 1. paramsからdailyProgramIdを取得
      daily_program_id = params[:dailyProgramId]

      # 2. daily_programsの更新
      daily_program = DailyProgram.find(daily_program_id)
      daily_program.update!(completed: true, date: Date.today)

      # 3. training_dayの新規作成または既存のものを取得
      user_id = daily_program.program_bundle.user_id
      training_day = TrainingDay.find_or_create_by(user_id: user_id, date: Date.today)
      Rails.logger.debug("training_day: #{training_day.inspect}")

      # 4. training_menusの更新
      params[:menus].each do |menu|
        training_menu = TrainingMenu.find_by(
          exercise_name: menu[:menuName],
          daily_program_id: daily_program_id
        )

        # レコードが見つからない場合、エラーメッセージを表示してロールバック
        if training_menu.nil?
          render json: { status: 'error', message: 'Training menu not found' }, status: :not_found
          raise ActiveRecord::Rollback
        end

        # 既存のtraining_menuのtraining_day_idを更新
        training_menu.update!(
          training_day_id: training_day.id,
          exercise_name: menu[:menuName],
          daily_program_id: daily_program_id
        )

        # 5. training_setsの更新または作成
        menu[:sets].each do |set|
          training_set = training_menu.training_sets.find_or_initialize_by(set_number: set[:setNumber])
          training_set.update!(
            set_number: set[:setNumber],
            weight: set[:weight],
            reps: set[:reps],
          )
        end
      end

      render json: { status: 'success' }
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Failed to update records: #{e.record.errors.full_messages}"
      render json: { status: 'error', errors: e.record.errors.full_messages }, status: :unprocessable_entity
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

  def check_completion
    date = params[:date]
    program_id = params[:program_id]

    Rails.logger.debug "Checking completion for date: #{date}, program_id: #{program_id}"

    # program_id から user_id を取得
    program = ProgramBundle.find(program_id)
    user_id = program.user_id

    completed = DailyProgram.joins(:program_bundle)
                            .where(program_bundles: { user_id: user_id })
                            .where(date: date, completed: true)
                            .exists?

    Rails.logger.debug "Completion status for user_id #{user_id} on date #{date}: #{completed}"
    render json: { isCompleted: completed }
  end

  private

    def training_day_params
      params.require(:training_day).permit(:date, menus: [:menuId, :menuName, :body_part, { sets: [:setId, :weight, :reps, :completed] }])
    end
end
