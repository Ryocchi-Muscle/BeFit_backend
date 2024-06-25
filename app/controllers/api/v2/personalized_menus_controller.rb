class Api::V2::PersonalizedMenusController < ApplicationController
  before_action :set_current_user

  def index
    program_bundle = @current_user.program_bundle

    if program_bundle
      program_json = program_bundle.as_json(include: {
                                              daily_programs: {
                                                include: :training_menus,
                                                except: [:created_at, :updated_at]
                                              }
                                            })
      render json: { program: program_json }, status: :ok
    else
      render json: { program: nil }, status: :ok
    end
  end

  def create_and_save
    puts "Received params: #{params.inspect}"
    gender = params[:gender]
    frequency = params[:frequency]
    duration = params[:duration]

    if @current_user.program_bundle.present?
      return render json: { error: "プログラムバンドルは既に存在します" }, status: :unprocessable_entity
    end

    program = generate_program(gender, frequency, duration)
    Rails.logger.debug "Generated program: #{program.inspect}"

    program_bundle = ProgramBundle.new(
      user: @current_user,
      gender: gender,
      frequency: frequency,
      duration: duration
    )
    Rails.logger.debug "Generated program_bundle1: #{program_bundle.inspect}"
    if program_bundle.save
      current_week = 1
      day_counter = 0
      program.each do |prog|
        if prog[:week] != current_week
          current_week = prog[:week]
          day_counter = 0
        end

        day_counter += 1

        daily_program = program_bundle.daily_programs.build(
          week: prog[:week],
          day: day_counter,
          details: prog[:details],
          date: nil
        )
        unless daily_program.save
          Rails.logger.error "Failed to save daily_program: #{daily_program.errors.full_messages}"
          render json: { errors: daily_program.errors.full_messages }, status: :unprocessable_entity
          return
        end
        Rails.logger.debug "Created daily_program: #{daily_program.inspect}"

        prog[:details].each do |menu|
          training_menu = daily_program.training_menus.build(
            exercise_name: menu[:menu],
            set_info: menu[:set_info]
          )
        # training_day_idを設定しない
          training_menu.training_day_id = nil

          next if training_menu.valid?

          Rails.logger.error "Failed to save training_menu: #{training_menu.errors.full_messages}"
          render json: { errors: daily_program.errors.full_messages }, status: :unprocessable_entity
          return
        end

        Rails.logger.debug "daily_program.training_menus: #{daily_program.training_menus.inspect}"

        next if daily_program.save

        Rails.logger.error "Failed to save daily_program: #{daily_program.errors.full_messages}"
        render json: { errors: daily_program.errors.full_messages }, status: :unprocessable_entity
        return
      end
      Rails.logger.debug "Generated program_bundle2: #{program_bundle.inspect}"
      Rails.logger.debug "Generated daily_programs: #{program_bundle.daily_programs.inspect}"

      program_json = program_bundle.as_json(include: {
                                              daily_programs: {
                                                include: :training_menus,
                                                except: [:created_at, :updated_at]
                                              }
                                            })
      Rails.logger.debug "Generated program JSON: #{program_json.inspect}"

      render json: { program: program_json }, status: :created
    else
      render json: { errors: program_bundle.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def save_daily_program
    daily_program = DailyProgram.find(params[:id])

    if daily_program.update(date: Date.today, completed: true)
      render json: daily_program, status: :ok
    else
      render json: { errors: daily_program.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    daily_program = DailyProgram.find(params[:id])
    program_details = params[:details]

    ActiveRecord::Base.transaction do
      program_details.each do |detail|
        training_menu = daily_program.training_menus.find_or_initialize_by(exercise_name: detail[:menuName])
        training_menu.set_info = detail[:sets].map { |set| "#{set[:reps]}回 #{set[:weight]}kg" }.join(', ')
        training_menu.save!

        detail[:sets].each do |set_detail|
          training_set = training_menu.training_sets.find_or_initialize_by(set_number: set_detail[:setNumber])

          # 更新対象フィールドが空でない場合のみ更新
          training_set.weight = set_detail[:weight] unless set_detail[:weight].blank?
          training_set.reps = set_detail[:reps] unless set_detail[:reps].blank?
          training_set.completed = set_detail[:completed] unless set_detail[:completed].nil?

          training_set.save!
        end

        training_menu.training_sets.where.not(set_number: detail[:sets].map { |set| set[:setNumber] }).destroy_all
      end

      daily_program.training_menus.where.not(exercise_name: program_details.map { |detail| detail[:menuName] }).destroy_all
    end

    if daily_program.save
      render json: daily_program, status: :ok
    else
      render json: { errors: daily_program.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def destroy
    program_bundle = @current_user.program_bundle
    if program_bundle.nil?
      render json: { success: false, errors: ["Program_bundle not found"] }, status: :not_found
    elsif program_bundle.destroy
      render json: { success: true, message: "deleted plans" }, status: :ok
    else
      render json: { success: false, errors: program_bundle.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def generate_program(gender, frequency, duration)
      base_programs = {
        '1' => {
          'male' => [
            { menu: "1.スクワット", set_info: "10回3セット インターバル3分" },
            { menu: "2.ベンチプレス", set_info: "10回3セット インターバル3分" },
            { menu: "3.デッドリフト", set_info: "10回2セット インターバル3分" },
            { menu: "4.懸垂", set_info: "10回3セット インターバル3分" },
            { menu: "5.サイドレイズ", set_info: "12回3セット インターバル1分" },
            { menu: "6.アブローラー", set_info: "10回3セット インターバル2分" }
          ],
          'female' => [
            { menu: "1.インナーサイ（ハム）", set_info: "15回3セット インターバル1分" },
            { menu: "2.アウターサイ（尻）", set_info: "15回3セット インターバル1分" },
            { menu: "3.スクワット (脚＆尻)", set_info: "10回3セット インターバル2~3分" },
            { menu: "4.ヒップスラスト(尻)", set_info: "10回3セット インターバル2~3分" },
            { menu: "5.ラットプルダウン（背中）", set_info: "12回3セット インターバル1~2分" },
            { menu: "6.シーテッドロウ（背中）", set_info: "10回3セット インターバル1分" },
            { menu: "7.アブローラー or 腹筋マシン（腹）", set_info: "10回3セット インターバル2分" }
          ]
        },
        '2' => {
          'male' => {
            'A' => [
              { menu: "1.スクワット", set_info: "10回3セット インターバル3分" },
              { menu: "2.ベンチプレス", set_info: "10回3セット インターバル3分" },
              { menu: "3.デッドリフト", set_info: "10回2セット インターバル3分" },
              { menu: "4.懸垂", set_info: "10回3セット インターバル3分" },
              { menu: "5.サイドレイズ", set_info: "12回3セット インターバル1分" },
              { menu: "6.ブローラー", set_info: "10回2セット インターバル2分" }
            ],
            'B' => [
              { menu: "1.スクワット", set_info: "10回3セット インターバル3分" },
              { menu: "ベンチプレス", set_info: "10回3セット インターバル3分" },
              { menu: "懸垂", set_info: "10回3セット インターバル3分" },
              { menu: "サイドレイズ", set_info: "12回3セット インターバル1分" },
              { menu: "アブローラー", set_info: "10回3セット インターバル2分" }
            ]
          },
          'female' => {
            'A' => [
              { menu: "1.インナーサイ（ハム）", set_info: "15回3セット インターバル1分" },
              { menu: "2.アウターサイ（尻）", set_info: "15回3セット インターバル1分" },
              { menu: "3.スクワット (脚＆尻)", set_info: "10回3セット インターバル2~3分" },
              { menu: "4.ケーブルヒップキックバック（尻）", set_info: "12回3セット インターバル1分" },
              { menu: "5.ラットプルダウン（背中）", set_info: "12回3セット インターバル1~2分" },
              { menu: "6.アブローラー（腹）", set_info: "10回3セット インターバル1分" }
            ],
            'B' => [
              { menu: "1.バックエクステンション（尻）", set_info: "15回3セット インターバル2分" },
              { menu: "2.ヒップスラスト(尻)", set_info: "8回3セット インターバル2~3分" },
              { menu: "3.ルーマニアンデッドリフト(ハム)", set_info: "12回3セット インターバル2分" },
              { menu: "4.シーテッドロウ（背中）", set_info: "10回3セット インターバル2分" },
              { menu: "5.腹筋マシン（腹）", set_info: "10回2セット インターバル2分" }
            ]
          }
        },
        '3' => {
          'male' => {
            'A' => [
              { menu: "1.スクワット", set_info: "10回3セット インターバル3分" },
              { menu: "2.ベンチプレス", set_info: "10回3セット インターバル3分" },
              { menu: "3.デッドリフト", set_info: "10回2セット インターバル3分" },
              { menu: "4.懸垂", set_info: "10回3セット インターバル3分" },
              { menu: "5.サイドレイズ", set_info: "12回3セット インターバル1分" },
              { menu: "6.アブローラー", set_info: "10回3セット インターバル2分" }
            ],
            'B' => [
              { menu: "1.スクワット", set_info: "10回3セット インターバル3分" },
              { menu: "2.ベンチプレス", set_info: "10回3セット インターバル3分" },
              { menu: "3.懸垂", set_info: "10回3セット インターバル3分" },
              { menu: "4.サイドレイズ", set_info: "12回3セット インターバル1分" },
              { menu: "5.アブローラー", set_info: "10回3セット インターバル2分" }
            ]
          },
          'female' => {
            'A' => [
              { menu: "1.スクワット (脚＆尻)", set_info: "10回3セット インターバル2~3分" },
              { menu: "2.ヒップスラスト(尻)", set_info: "8回3セット インターバル2~3分" },
              { menu: "3.ルーマニアンデッドリフト(ハム)", set_info: "12回3セット インターバル2分" },
              { menu: "4.ラットプルダウン（背中）", set_info: "12回3セット インターバル1~2分" },
              { menu: "5.ケーブルヒップキックバック（尻）", set_info: "12回3セット インターバル1分" },
              { menu: "6.アブローラー（腹）", set_info: "10回3セット インターバル1分" }
            ],
            'B' => [
              { menu: "1.インナーサイ（ハム）", set_info: "15回3セット インターバル1分" },
              { menu: "2.アウターサイ（尻）", set_info: "15回3セット インターバル1分" },
              { menu: "3.シーテッドロウ（背中）", set_info: "10回3セット インターバル2分" },
              { menu: "4. ブルガリアンスクワット（脚＆尻）", set_info: "10回3セット インターバル2分" },
              { menu: "5.バックエクステンション（尻）", set_info: "15回3セット インターバル2分" },
              { menu: "6.腹筋マシン（腹）", set_info: "10回3セット インターバル2分" }
            ]
          }
        },
        '4' => {
          'male' => {
            'A' => [
              { menu: "1.スクワット", set_info: "10回3セット インターバル3分" },
              { menu: "2.デッドリフト", set_info: "10回3セット インターバル3分" },
              { menu: "3.ブルガリアンスクワット", set_info: "10回3セット インターバル1分" },
              { menu: "4.アブローラー", set_info: "10回3セット インターバル2分" }
            ],
            'B' => [
              { menu: "1.ベンチプレス", set_info: "10回3セット インターバル3分" },
              { menu: "2.懸垂", set_info: "10回3セット インターバル3分" },
              { menu: "3.サイドレイズ", set_info: "12回3セット インターバル1分" },
              { menu: "4.ダンベルカール", set_info: "10回3セット インターバル60〜90秒" },
              { menu: "5.ライイングトライセプスEX", set_info: "10回3セット インターバル60〜90秒" }
            ],
            'D' => [
              { menu: "1.スクワット", set_info: "10回3セット インターバル3分" },
              { menu: "2.ブルガリアンスクワット", set_info: "10回3セット インターバル1分" },
              { menu: "3.懸垂", set_info: "10回3セット インターバル3分" },
              { menu: "4.インクラインダンベルカール", set_info: "10回3セット インターバル60〜90秒" },
              { menu: "5.アブローラー", set_info: "10回3セット インターバル2分" }
            ],
            'E' => [
              { menu: "1.ベンチプレス", set_info: "10回3セット インターバル3分" },
              { menu: "2.サイドレイズ", set_info: "12回3セット インターバル1分" },
              { menu: "3.ショルダープレス", set_info: "10回3セット インターバル3分" },
              { menu: "4.ライイングトライセプスEX", set_info: "10回3セット インターバル60〜90秒" }
            ]
          },
          'female' => {
            'A' => [
              { menu: "1.スクワット (脚＆尻)", set_info: "10回3セット インターバル2~3分" },
              { menu: "2.ヒップスラスト(尻)", set_info: "10回3セット インターバル2~3分" },
              { menu: "3.ルーマニアンデッドリフト(ハム)", set_info: "12回3セット インターバル2分" },
              { menu: "4.シーテッドロウ（背中）", set_info: "10回3セット インターバル2分" }
            ],
            'B' => [
              { menu: "1.インナーサイ（ハム）", set_info: "15回3セット インターバル1分" },
              { menu: "2.アウターサイ（尻）", set_info: "15回3セット インターバル1分" },
              { menu: "3.バックエクステンション（尻）", set_info: "15回3セット インターバル2分" },
              { menu: "4.ブルガリアンスクワット（脚＆尻）", set_info: "10回3セット インターバル2分" },
              { menu: "5.シーテッドロウ（背中）", set_info: "10回3セット インターバル2分" },
              { menu: "6.アブローラー（腹）", set_info: "10回3セット インターバル1分" }
            ],
            'D' => [
              { menu: "1.スクワット (脚＆尻)", set_info: "10回3セット インターバル2~3分" },
              { menu: "2.ヒップスラスト(尻)", set_info: "10回3セット インターバル2~3分" },
              { menu: "3.ルーマニアンデッドリフト(ハム)", set_info: "12回3セット インターバル2分" },
              { menu: "4.ラットプルダウン（背中）", set_info: "12回3セット インターバル1~2分" },
              { menu: "5.ケーブルヒップキックバック（尻）", set_info: "12回3セット インターバル1分" }
            ],
            'E' => [
              { menu: "1.バックエクステンション（尻）", set_info: "15回3セット インターバル2分" },
              { menu: "2.ブルガリアンスクワット（脚＆尻）", set_info: "10回3セット インターバル2分" },
              { menu: "3.レッグプレス（脚）", set_info: "8回3セット インターバル2分" },
              { menu: "4.シーテッドロウ（背中）", set_info: "10回3セット インターバル2分" },
              { menu: "5.腹筋マシン（腹）", set_info: "10回3セット インターバル2分" }
            ]
          }
        }
      }

      program_sequence = case frequency.to_i
                         when 1
                           [nil]
                         when 2
                           %w[A B]
                         when 3
                           %w[A B A]
                         when 4
                           %w[A B D E]
                         when 5
                           %w[A B D E A]
                         when 6
                           %w[A B D E A B]
                         else
                           %w[A B]
                         end

      program = []
      duration.to_i.times do |week|
        program_sequence.each do |prog|
          puts "Accessing base_programs with frequency: #{frequency}, gender: #{gender}, prog: #{prog}"
          details = if frequency.to_i == 1
            # frequency が 1 の場合、配列を直接使用
                      base_programs[frequency.to_s][gender] || []
                    else
                      base_programs[frequency.to_s][gender][prog] || []
                    end
          program << { week: week + 1, details: details }
        end
      end
      program
    end
end
