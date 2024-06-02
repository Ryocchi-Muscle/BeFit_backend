class Api::V2::ProgramsController < ApplicationController
  before_action :set_current_user

  def index
    program_bundle = @current_user.program_bundle
    render json: { program_bundle: program_bundle}
  end

  def create
    Rails.logger.debug "program_bundle Params: #{params[:program_bundle].inspect}"

    if @current_user.program_bundle.present?
      Rails.logger.debug "@current_user.program_bundle: #{@current_user.program_bundle.inspect}"
      render json: { success: false, errors: ["Program_bundle already exists"] }, status: :unprocessable_entity
      return
    end

    program_bundle_params = params.require(:program_bundle).permit(:week,details: [:menu, :set_info, :other])

      program_bundle = ProgramBundle.new(program_bundle_params)
      program_bundle.user = @current_user

      if  program_bundle.save
        render json: { sucess: true, progmram: program_bundle}, status: :created
      else
        render json: { success: false, errors: program_bundle.errors.full_messages }, status: :unprocessable_entity
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
end
