class Api::V2::ProgramsController < ApplicationController
  before_action :set_current_user

  def create
    program_params = params.require(:program).permit(:gender, :frequency, :duration, details: [:menu, :set_info, :other])

    program = Program.new(program_params)
    program.user = @current_user

    if program.after_save
      render json: { success: true, program: program }, status: :created
    else
      render json: { success: false, errors: program.full_messages }, status: :unprocessable_entity
    end
  end
end
