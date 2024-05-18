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
      case gender
      when 'male'
        case frequency
        when '1'
          %w[プログラムA1 プログラムA2]
        when '2'
          %w[プログラムB1 プログラムB2]
        when '3'
          %w[プログラムC1 プログラムC2]
        end
      when 'female'
        case frequency
        when '1'
          %w[プログラムD1 プログラムD2]
        when '2'
          %w[プログラムE1 プログラムE2]
        when '3'
          %w[プログラムF1 プログラムF2]
        end
      end
    end
end
