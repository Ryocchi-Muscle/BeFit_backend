class Api::V2::PersonalizedMenusController < ApplicationController
  before_action :set_current_user
  def create
    gender = params[:gender]
    frequency = params[:frequency]
    duration = params[:duration].to_i

    program = generate_program(@current_user, gender, frequency, duration)

    render json: { program: program }
  end

  private

    def generate_program(user, gender, frequency, duration)
      base_url = request.base_url
      Rails.logger.debug "Base URL: #{base_url}"

      user.training_programs.by_gender(gender).by_frequency(frequency).by_duration(duration).map do |program|
        {
          title: program.title,
          details: program.training_menus.map do |menu|
            {
              menu: menu.exercise_name,
              set_info: menu.set_info,
              other: menu.other
            }
          end
        }
      end
    end
end
