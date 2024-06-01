class Api::V2::ProgramsController < ApplicationController
  before_action :set_current_user

  def create
    Rails.logger.debug "Program Params: #{params[:program].inspect}"

    program_params = params.require(:program).map do |p|
      ActionController::Parameters.new(p.to_unsafe_h).permit(:week, details: [:menu, :set_info, :other])
    end

    # 例: 各プログラムを個別に保存
    programs = program_params.map do |program_params|
      program = Program.new(program_params)
      program.user = @current_user
      program.save
      program
    end


    if programs.all?(&:persisted?)
      render json: { success: true, programs: programs }, status: :created
    else
      render json: { success: false, errors: programs.map(&:errors).map(&:full_messages) }, status: :unprocessable_entity
    end
  end
end
