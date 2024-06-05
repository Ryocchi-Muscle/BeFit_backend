class Api::V2::PersonalizedMenusController < ApplicationController
  before_action :set_current_user

  def create_and_save
    puts "Received params: #{params.inspect}"
    gender = params[:gender]
    frequency = params[:frequency]
    duration = params[:duration]

    program = generate_program(gender, frequency, duration)
    Rails.logger.debug "Generated program: #{program.inspect}"

    program_bundle = ProgramBundle.create(
      user: @current_user,
      gender: gender,
      frequency: frequency,
      duration: duration
    )
    Rails.logger.debug "Generated program_bundle: #{program_bundle.inspect}"

    if program_bundle.save
      program.each do |prog|
        prog[:details].each do |detail|
          daily_program = program_bundle.daily_programs.create(
            details: detail.to_json,
            week: prog[:week]
          )
          Rails.logger.debug "Created daily_program: #{daily_program.inspect}"
          unless daily_program.persisted?
          Rails.logger.error "Failed to save daily_program: #{daily_program.errors.full_messages}"
          end
        end
      end
      Rails.logger.debug "Generated daily_programs: #{program_bundle.daily_programs.inspect}"

    render json: { program: program_bundle, daily_programs: program_bundle.daily_programs }, status: :created
    else
      render json: { errors: program_bundle.errors.full_messages }, status: :unprocessable_entity
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
