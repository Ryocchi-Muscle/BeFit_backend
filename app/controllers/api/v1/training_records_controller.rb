class Api::V1::TrainingRecordsController < ApplicationController
  def create
    result = TrainingRecord.Service.create_record(params)
    render json: result, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.errors.full_messgaes }, status: :unprocessable_entity
  end
end
