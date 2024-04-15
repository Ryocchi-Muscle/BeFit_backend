class TrainingRecordService
  def self.create_record(params)
    ActiveRecord::Base.transaction do
      day = TrainingDaysService.create(params[:day_params])
      menu = TrainingMenusService.create(day, params[:menu_params])
      set = TrainingSetsService.create(menu, params[:set_params])
      return { day: day, menu: menu, set: set }
    end
  end
end
