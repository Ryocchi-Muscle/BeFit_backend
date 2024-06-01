class Api::V2::ProgramsController < ApplicationController
  before_action :set_current_user

  def index
    program = Program.where(user: @current_user)
    render json: { program: program}
  end

  def create
    Rails.logger.debug "Program Params: #{params[:program].inspect}"

    if @current_user.programs.present?
      render json: { success: false, errors: ["Program already exists"] }, status: :unprocessable_entity
      return
    end

    program_params = params.require(:program).permit(:week,details: [:menu, :set_info, :other])

      program = Program.new(program_params)
      program.user = @current_user

      if program.after_save
        render json: { sucess: true, progmram: program}, status: :created
      else
        render json: { success: false, errors: program.errors.full_messages }, status: :unprocessable_entity
      end
  end

  def destroy
    program = @current_user.program
    if program.nil?
      render json: { success: false, errors: ["Program not found"] }, status: :not_found
    elsif program.destroy
     render json: { success: true, message: "deleted plans" }, status: :ok
    else
      render json: { success: false, errors: program.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
