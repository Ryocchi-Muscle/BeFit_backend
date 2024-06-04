class Api::V2::ProgramsController < ApplicationController
  before_action :set_current_user

  def index
    program_bundle = @current_user.program_bundle
    Rails.logger.debug "program_bundle: #{program_bundle.inspect}"
    render json: { program: program_bundle}
  end

  def create
    Rails.logger.debug "program_bundle Params: #{params[:program_bundle].inspect}"
    Rails.logger.debug "Details Params: #{params[:details].inspect}"

    if @current_user.program_bundle.present?
      Rails.logger.debug "@current_user.program_bundle: #{@current_user.program_bundle.inspect}"
      Rails.logger.debug "ああ"
      render json: { success: false, errors: ["Program_bundle already exists"] }, status: :unprocessable_entity
      return
    end

    program_bundle_params = params.require(:program_bundle).permit(:gender, :frequency, :week)
    Rails.logger.debug "program_bundle_params: #{program_bundle_params.inspect}"
    program_bundle = ProgramBundle.new(program_bundle_params)
    program_bundle.user = @current_user

    if  program_bundle.save
      details_params = params.require(:details).map do |detail|
        detail.permit(:menu, :set_info, :week, :day)
      end

      Rails.logger.debug "Details Params: #{details_params.inspect}"

      daily_programs = details_params.map do |detail|
        day = calculate_day(detail[:week])
        program_bundle.daily_programs.build(
          details: {
            menu: detail[:menu],
            set_info: detail[:set_info],
          },
          week: detail[:week],
          day: day,
        )
      end
      Rails.logger.debug "Daily Programs: #{daily_programs.inspect}"
      begin
        daily_programs.all?(&:save!)
      rescue => exception
        Rails.logger.debug "Daily Programs Save Errors1: #{exception}"
      end

      if daily_programs.all?(&:save)
        render json: { sucess: true, progmram: program_bundle}, status: :created
      else
        Rails.logger.debug "Daily Programs Save Errors: #{daily_programs.map(&:errors).map(&:full_messages)}"
        render json: { success: false, errors: program_bundle.errors.full_messages }, status: :unprocessable_entity
      end
    else
      Rails.logger.debug "Program Bundle Save Errors: #{program_bundle.errors.full_messages}"
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
