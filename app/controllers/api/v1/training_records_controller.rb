class TrainingRecordsController < ApplicationController
  before_action :set_training_record, only: [:update, :destroy]
  # GET /todos
  def index
    @training_records = if params[:date]
                          current_user.training_records.where(date: params[:date])
                        else
                          current_user.training_records
                        end

    render json: @training_records.includes(:training_sets)
  end

  def create
    @training_record = TrainingRecord.new(training_record_params)
    if @training_record.save
      render json: @training_record, status: :created
    else
      render json: @training_record.errors, status: :unprocessable_entity
    end
  end

  def update
    if @training_record.update(training_record_params)
      render json: @training_record
    else
      render json: @training_record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @training_record.destroy
    head :no_content # 削除が成功した場合にはステータスコード204（No Content）を返す
  end

  private

    def set_training_record
      @training_record = TrainingRecord.find(params[:id])
    end

    def training_record_params
      params.require(:training_record).permit(:date, :body_part, :menu,
                                              training_sets_attributes: [:id, :weight, :reps, :completed, :_destroy])
    end
end
