class Api::V2::PersonalizedMenusController < ApplicationController
  before_action :set_current_user
  def create
    gender = params[:gender]
    frequency = params[:frequency]

    program = generate_program(gender, frequency)

    render json: { program: program }
  end

  private

  def generate_program(gender, frequency)
    base_url = request.base_url
     Rails.logger.debug "Base URL: #{base_url}"
    base_url = request.base_url
    case gender
    when 'male'
      case frequency
      when '1'
          [
          {
            title: "週に1回のプログラム",
            image: "#{base_url}/images/images.jpeg",
            details: [
              "スクワット: 10回3セット, インターバル3分",
              "スクワット: メインセットから重量を15%落として限界まで1セット, インターバル1分",
              "ベンチプレス: 10回3セット, インターバル3分 (時間なければ2分)",
              "ベンチプレス: メインセットから重量を15%落として限界まで1セット, インターバル1分",
              "デッドリフト: 10回2セット, インターバル3分",
              "懸垂: インターバル3分",
              "サイドレイズ: 12回3セット, インターバル1分",
              "アブローラー: 2セット, インターバル2分",
              "※はじめの15%落として限界まで行うセットはこのプログラムを始めて1ヶ月以上経過してから取り入れてください。それまでは10回3セットだけでOKです。"
            ]
          }
        ]
      when '2-3'
                  [
          {
            title: "週に2-3回のプログラム",
            image: "#{base_url}/images/images.jpeg",
            details: [
              "スクワット: 10回3セット, インターバル3分",
              "スクワット: メインセットから重量を15%落として限界まで1セット, インターバル1分",
              "ベンチプレス: 10回3セット, インターバル3分 (時間なければ2分)",
              "ベンチプレス: メインセットから重量を15%落として限界まで1セット, インターバル1分",
              "デッドリフト: 10回2セット, インターバル3分",
              "懸垂: インターバル3分",
              "サイドレイズ: 12回3セット, インターバル1分",
              "アブローラー: 2セット, インターバル2分",
              "※はじめの15%落として限界まで行うセットはこのプログラムを始めて1ヶ月以上経過してから取り入れてください。それまでは10回3セットだけでOKです。"
            ]
          }
        ]
      when '4-6'
        ["プログラムC1", "プログラムC2"]
      end
    when 'female'
      case frequency
      when '1'
        ["プログラムD1", "プログラムD2"]
      when '2-3'
        ["プログラムE1", "プログラムE2"]
      when '4-6'
        ["プログラムF1", "プログラムF2"]
      end
    end
  end
end
