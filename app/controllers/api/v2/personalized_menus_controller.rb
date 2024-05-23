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

      case gender
      when 'male'
        case frequency
        when '1'
          [
            {
              title: "週に1回のプログラム①",
              image: "#{base_url}/images/images.jpeg",
              details: [
                { menu: "スクワット", set_info: "10回3セット, インターバル3分", other: "※メインセットから重量を15%落として限界まで1セット" },
                { menu: "ベンチプレス", set_info: "10回3セット, インターバル2-3分", other: "メインセットから重量を15%落として限界まで1セット, インターバル1分" },
                { menu: "デッドリフト", set_info: "10回2セット, インターバル3分", other: "" }
              ]
            },
            {
              title: "週に1回のプログラム②",
              image: "#{base_url}/images/program_2_3_B.jpg",
              details: [
                { menu: "デッドリフト", set_info: "10回2セット, インターバル3分", other: "" },
                { menu: "懸垂", set_info: "インターバル3分", other: "" },
                { menu: "サイドレイズ", set_info: "12回3セット, インターバル1分", other: "" },
                { menu: "アブローラー", set_info: "2セット, インターバル2分", other: "※はじめの15%落として限界まで行うセットはこのプログラムを始めて1ヶ月以上経過してから取り入れてください。それまでは10回3セットだけでOKです。" }
              ]
            }
          ]
        when '2-3'
          [
            {
              title: "週に2-3回のプログラム A",
              image: "#{base_url}/images/program_2_3_A.jpg",
              details: [
                { menu: "スクワット", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "ベンチプレス", set_info: "10回3セット, インターバル3分 (時間がなければ2分)", other: "" },
                { menu: "デッドリフト", set_info: "10回2セット, インターバル3分", other: "" },
                { menu: "懸垂", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "サイドレイズ", set_info: "12回3セット, インターバル1分", other: "" },
                { menu: "アブローラー", set_info: "10回2セット, インターバル2分", other: "" }
              ]
            },
            {
              title: "週に2-3回のプログラム B",
              image: "#{base_url}/images/program_2_3_B.jpg",
              details: [
                { menu: "スクワット", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "ベンチプレス", set_info: "10回3セット, インターバル3分 (時間がなければ2分)", other: "" },
                { menu: "懸垂", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "サイドレイズ", set_info: "12回3セット, インターバル1分", other: "" },
                { menu: "アブローラー", set_info: "10回2セット, インターバル2分", other: "" }
              ]
            }
          ]
        when '4-6'
          [
            {
              title: "週に4-6回のプログラム A",
              image: "#{base_url}/images/program_4_6_A.jpg",
              details: [
                { menu: "スクワット", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "デッドリフト", set_info: "10回3セット, インターバル3分 (時間がなければ2分)", other: "" },
                { menu: "ブルガリアンスクワット", set_info: "10回3セット, インターバル1分", other: "" },
                { menu: "アブローラー", set_info: "10回2セット, インターバル2分", other: "" }
              ]
            },
            {
              title: "週に4-6回のプログラム B",
              image: "#{base_url}/images/program_4_6_B.jpg",
              details: [
                { menu: "ベンチプレス", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "懸垂", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "サイドレイズ", set_info: "12回3セット, インターバル1分", other: "" },
                { menu: "ダンベルカール", set_info: "10回3セット, インターバル60〜90秒", other: "" },
                { menu: "ライイングトライセプスEX", set_info: "10回3セット, インターバル60〜90秒", other: "" }
              ]
            },
            {
              title: "週に4-6回のプログラム C",
              image: "#{base_url}/images/program_4_6_C.jpg",
              details: [
                { menu: "スクワット", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "ブルガリアンスクワット", set_info: "10回3セット, インターバル1分", other: "" },
                { menu: "懸垂", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "インクラインダンベルカール", set_info: "10回3セット, インターバル60〜90秒", other: "" },
                { menu: "アブローラー", set_info: "10回2セット, インターバル2分", other: "" }
              ]
            },
            {
              title: "週に4-6回のプログラム D",
              image: "#{base_url}/images/program_4_6_D.jpg",
              details: [
                { menu: "休み", set_info: "", other: "" }
              ]
            },
            {
              title: "週に4-6回のプログラム E",
              image: "#{base_url}/images/program_4_6_E.jpg",
              details: [
                { menu: "ベンチプレス", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "サイドレイズ", set_info: "12回3セット, インターバル1分", other: "" },
                { menu: "ショルダープレス", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "ライイングトライセプスEX", set_info: "10回3セット, インターバル60〜90秒", other: "" }
              ]
            },
            {
              title: "週に4-6回のプログラム F",
              image: "#{base_url}/images/program_4_6_F.jpg",
              details: [
                { menu: "休み", set_info: "", other: "" }
              ]
            }
          ]
        end
      when 'female'
        case frequency
        when '1'
          [
            {
              title: "週に1回のプログラム①",
              image: "#{base_url}/images/images.jpeg",
              details: [
                { menu: "スクワット", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "スクワット", set_info: "メインセットから重量を15%落として限界まで1セット, インターバル1分", other: "" },
                { menu: "ベンチプレス", set_info: "10回3セット, インターバル3分 (時間なければ2分)", other: "" },
                { menu: "ベンチプレス", set_info: "メインセットから重量を15%落として限界まで1セット, インターバル1分", other: "" }
              ]
            },
            {
              title: "週に1回のプログラム②",
              image: "#{base_url}/images/program_2_3_B.jpg",
              details: [
                { menu: "デッドリフト", set_info: "10回2セット, インターバル3分", other: "" },
                { menu: "懸垂", set_info: "インターバル3分", other: "" },
                { menu: "サイドレイズ", set_info: "12回3セット, インターバル1分", other: "" },
                { menu: "アブローラー", set_info: "2セット, インターバル2分", other: "※はじめの15%落として限界まで行うセットはこのプログラムを始めて1ヶ月以上経過してから取り入れてください。それまでは10回3セットだけでOKです。" }
              ]
            }
          ]
        when '2-3'
          [
            {
              title: "週に2-3回のプログラム A",
              image: "#{base_url}/images/program_2_3_A.jpg",
              details: [
                { menu: "スクワット", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "ベンチプレス", set_info: "10回3セット, インターバル3分 (時間がなければ2分)", other: "" },
                { menu: "デッドリフト", set_info: "10回2セット, インターバル3分", other: "" },
                { menu: "懸垂", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "サイドレイズ", set_info: "12回3セット, インターバル1分", other: "" },
                { menu: "アブローラー", set_info: "10回2セット, インターバル2分", other: "" }
              ]
            },
            {
              title: "週に2-3回のプログラム B",
              image: "#{base_url}/images/program_2_3_B.jpg",
              details: [
                { menu: "スクワット", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "ベンチプレス", set_info: "10回3セット, インターバル3分 (時間がなければ2分)", other: "" },
                { menu: "懸垂", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "サイドレイズ", set_info: "12回3セット, インターバル1分", other: "" },
                { menu: "アブローラー", set_info: "10回2セット, インターバル2分", other: "" }
              ]
            }
          ]
        when '4-6'
          [
            {
              title: "週に4-6回のプログラム A",
              image: "#{base_url}/images/program_4_6_A.jpg",
              details: [
                { menu: "スクワット", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "デッドリフト", set_info: "10回3セット, インターバル3分 (時間がなければ2分)", other: "" },
                { menu: "ブルガリアンスクワット", set_info: "10回3セット, インターバル1分", other: "" },
                { menu: "アブローラー", set_info: "10回2セット, インターバル2分", other: "" }
              ]
            },
            {
              title: "週に4-6回のプログラム B",
              image: "#{base_url}/images/program_4_6_B.jpg",
              details: [
                { menu: "ベンチプレス", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "懸垂", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "サイドレイズ", set_info: "12回3セット, インターバル1分", other: "" },
                { menu: "ダンベルカール", set_info: "10回3セット, インターバル60〜90秒", other: "" },
                { menu: "ライイングトライセプスEX", set_info: "10回3セット, インターバル60〜90秒", other: "" }
              ]
            },
            {
              title: "週に4-6回のプログラム C",
              image: "#{base_url}/images/program_4_6_C.jpg",
              details: [
                { menu: "スクワット", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "ブルガリアンスクワット", set_info: "10回3セット, インターバル1分", other: "" },
                { menu: "懸垂", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "インクラインダンベルカール", set_info: "10回3セット, インターバル60〜90秒", other: "" },
                { menu: "アブローラー", set_info: "10回2セット, インターバル2分", other: "" }
              ]
            },
            {
              title: "週に4-6回のプログラム D",
              image: "#{base_url}/images/program_4_6_D.jpg",
              details: [
                { menu: "休み", set_info: "", other: "" }
              ]
            },
            {
              title: "週に4-6回のプログラム E",
              image: "#{base_url}/images/program_4_6_E.jpg",
              details: [
                { menu: "ベンチプレス", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "サイドレイズ", set_info: "12回3セット, インターバル1分", other: "" },
                { menu: "ショルダープレス", set_info: "10回3セット, インターバル3分", other: "" },
                { menu: "ライイングトライセプスEX", set_info: "10回3セット, インターバル60〜90秒", other: "" }
              ]
            },
            {
              title: "週に4-6回のプログラム F",
              image: "#{base_url}/images/program_4_6_F.jpg",
              details: [
                { menu: "休み", set_info: "", other: "" }
              ]
            }
          ]
        end
      end
    end
end
