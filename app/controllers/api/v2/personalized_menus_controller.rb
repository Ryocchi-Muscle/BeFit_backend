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

    # 既存のプログラムバンドルを確認
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
            details: prog[:details]
          )
          daily_program.save!
          Rails.logger.debug "Created daily_program: #{daily_program.inspect}"

          prog[:details].each do |menu|
            training_menu = daily_program.training_menus.build(
              exercise_name: menu[:menu],
              set_info: menu[:set_info]
          )
          # training_day_idを設定しない
            training_menu.training_day_id = nil

            unless training_menu.valid?
              Rails.logger.error "Failed to save training_menu: #{training_menu.errors.full_messages}"
              render json: { errors: daily_program.errors.full_messages }, status: :unprocessable_entity
              return
            end
          end

        Rails.logger.debug "daily_program.training_menus: #{daily_program.training_menus.inspect}"

      unless daily_program.save
        Rails.logger.error "Failed to save daily_program: #{daily_program.errors.full_messages}"
        render json: { errors: daily_program.errors.full_messages }, status: :unprocessable_entity
        return
      end
     end
      Rails.logger.debug "Generated program_bundle2: #{program_bundle.inspect}"
      Rails.logger.debug "Generated daily_programs: #{program_bundle.daily_programs.inspect}"


       program_json =  program_bundle.as_json(include: {
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
          { menu: "スクワット", set_info: "10回3セット インターバル3分" },
          { menu: "ベンチプレス", set_info: "10回3セット インターバル3分" },
          { menu: "デッドリフト", set_info: "10回2セット インターバル3分" },
          { menu: "懸垂", set_info: "10回3セット インターバル3分" },
          { menu: "サイドレイズ", set_info: "12回3セット インターバル1分" },
          { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
        ],
        'female' => [
          { menu: "スクワット", set_info: "8回3セット インターバル2分" },
          { menu: "ベンチプレス", set_info: "8回3セット インターバル2分" },
          { menu: "デッドリフト", set_info: "8回2セット インターバル2分" },
          { menu: "懸垂", set_info: "8回3セット インターバル2分" },
          { menu: "サイドレイズ", set_info: "10回3セット インターバル1分" },
          { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
        ]
      },
      '2' => {
        'male' => {
          'A' => [
            { menu: "スクワット", set_info: "10回3セット インターバル3分" },
            { menu: "ベンチプレス", set_info: "10回3セット インターバル3分" },
            { menu: "デッドリフト", set_info: "10回2セット インターバル3分" },
            { menu: "懸垂", set_info: "10回3セット インターバル3分" },
            { menu: "サイドレイズ", set_info: "12回3セット インターバル1分" },
            { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
          ],
          'B' => [
            { menu: "スクワット", set_info: "10回3セット インターバル3分" },
            { menu: "ベンチプレス", set_info: "10回3セット インターバル3分" },
            { menu: "懸垂", set_info: "10回3セット インターバル3分" },
            { menu: "サイドレイズ", set_info: "12回3セット インターバル1分" },
            { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
          ]
        },
        'female' => {
          'A' => [
            { menu: "スクワット", set_info: "8回3セット インターバル2分" },
            { menu: "ベンチプレス", set_info: "8回3セット インターバル2分" },
            { menu: "デッドリフト", set_info: "8回2セット インターバル2分" },
            { menu: "懸垂", set_info: "8回3セット インターバル2分" },
            { menu: "サイドレイズ", set_info: "10回3セット インターバル1分" },
            { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
          ],
          'B' => [
            { menu: "スクワット", set_info: "8回3セット インターバル2分" },
            { menu: "ベンチプレス", set_info: "8回3セット インターバル2分" },
            { menu: "懸垂", set_info: "8回3セット インターバル2分" },
            { menu: "サイドレイズ", set_info: "10回3セット インターバル1分" },
            { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
          ]
        }
      },
      '3' => {
        'male' => {
          'A' => [
            { menu: "スクワット", set_info: "10回3セット インターバル3分" },
            { menu: "ベンチプレス", set_info: "10回3セット インターバル3分" },
            { menu: "デッドリフト", set_info: "10回2セット インターバル3分" },
            { menu: "懸垂", set_info: "10回3セット インターバル3分" },
            { menu: "サイドレイズ", set_info: "12回3セット インターバル1分" },
            { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
          ],
          'B' => [
            { menu: "スクワット", set_info: "10回3セット インターバル3分" },
            { menu: "ベンチプレス", set_info: "10回3セット インターバル3分" },
            { menu: "懸垂", set_info: "10回3セット インターバル3分" },
            { menu: "サイドレイズ", set_info: "12回3セット インターバル1分" },
            { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
          ]
        },
        'female' => {
          'A' => [
            { menu: "スクワット", set_info: "8回3セット インターバル2分" },
            { menu: "ベンチプレス", set_info: "8回3セット インターバル2分" },
            { menu: "デッドリフト", set_info: "8回2セット インターバル2分" },
            { menu: "懸垂", set_info: "8回3セット インターバル2分" },
            { menu: "サイドレイズ", set_info: "10回3セット インターバル1分" },
            { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
          ],
          'B' => [
            { menu: "スクワット", set_info: "8回3セット インターバル2分" },
            { menu: "ベンチプレス", set_info: "8回3セット インターバル2分" },
            { menu: "懸垂", set_info: "8回3セット インターバル2分" },
            { menu: "サイドレイズ", set_info: "10回3セット インターバル1分" },
            { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
          ]
        }
      },
      '4' => {
        'male' => {
          'A' => [
            { menu: "スクワット", set_info: "10回3セット インターバル3分" },
            { menu: "デッドリフト", set_info: "10回3セット インターバル3分" },
            { menu: "ブルガリアンスクワット", set_info: "10回3セット インターバル1分" },
            { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
          ],
          'B' => [
            { menu: "ベンチプレス", set_info: "10回3セット インターバル3分" },
            { menu: "懸垂", set_info: "10回3セット インターバル3分" },
            { menu: "サイドレイズ", set_info: "12回3セット インターバル1分" },
            { menu: "ダンベルカール", set_info: "10回3セット インターバル60〜90秒" },
            { menu: "ライイングトライセプスEX", set_info: "10回3セット インターバル60〜90秒" }
          ],
          'D' => [
            { menu: "スクワット", set_info: "10回3セット インターバル3分" },
            { menu: "ブルガリアンスクワット", set_info: "10回3セット インターバル1分" },
            { menu: "懸垂", set_info: "10回3セット インターバル3分" },
            { menu: "インクラインダンベルカール", set_info: "10回3セット インターバル60〜90秒" },
            { menu: "アブローラー", set_info: "10回2セット インターバル2分" }
          ],
          'E' => [
            { menu: "ベンチプレス", set_info: "10回3セット インターバル3分" },
            { menu: "サイドレイズ", set_info: "12回3セット インターバル1分" },
            { menu: "ショルダープレス", set_info: "10回3セット インターバル3分" },
            { menu: "ライイングトライセプスEX", set_info: "10回3セット インターバル60〜90秒" }
          ]
        },
        'female' => {
          'A' => [
            { menu: "スクワット", set_info: "8回3セット インターバル2分" },
            { menu: "デッドリフト", set_info: "8回3セット インターバル2分" },
            { menu: "ブルガリアンスクワット", set_info: "8回3セット インターバル1分" },
            { menu: "アブローラー", set_info: "8回2セット インターバル2分" }
          ],
          'B' => [
            { menu: "ベンチプレス", set_info: "8回3セット インターバル2分" },
            { menu: "懸垂", set_info: "8回3セット インターバル2分" },
            { menu: "サイドレイズ", set_info: "10回3セット インターバル1分" },
            { menu: "ダンベルカール", set_info: "8回3セット インターバル60〜90秒" },
            { menu: "ライイングトライセプスEX", set_info: "8回3セット インターバル60〜90秒" }
          ],
          'D' => [
            { menu: "スクワット", set_info: "8回3セット インターバル2分" },
            { menu: "ブルガリアンスクワット", set_info: "8回3セット インターバル1分" },
            { menu: "懸垂", set_info: "8回3セット インターバル2分" },
            { menu: "インクラインダンベルカール", set_info: "8回3セット インターバル60〜90秒" },
            { menu: "アブローラー", set_info: "8回2セット インターバル2分" }
          ],
          'E' => [
            { menu: "ベンチプレス", set_info: "8回3セット インターバル2分" },
            { menu: "サイドレイズ", set_info: "10回3セット インターバル1分" },
            { menu: "ショルダープレス", set_info: "8回3セット インターバル2分" },
            { menu: "ライイングトライセプスEX", set_info: "8回3セット インターバル60〜90秒" }
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
        if frequency.to_i == 1
          # frequency が 1 の場合、配列を直接使用
          details = base_programs[frequency.to_s][gender] || []
        else
          details = base_programs[frequency.to_s][gender][prog] || []
        end
         program << { week: week + 1, details: details }
        end
      end
    program
  end
end
