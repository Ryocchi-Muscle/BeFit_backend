class TrainingRecordsController < ApplicationController
  # GET /todos
  def index
    @training_records = TrainingRecord.all
    render json: @training_records
  end

  def create
    @training_record = TrainingRecord.new(training_record_params)
    if @training_record.save
      render json: @training_record, status: :created, location: @training_record
    else
      render json: @training_record.errors, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(training_record_params)
      render json: @training_record
    else
      render json: @training_record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @training_record.destroy
  end

  private

    def set_training_record
      @training_record = TrainingRecord.find(params[:id])
    end

    def training_record_params
      params.require(:training_record).permit(:title, :completed)
    end
end
