class TrainingDaySerializer < ActiveModel::Serializer
  attributes :id, :date, :total_weight

  has_many :training_menus

  def total_weight
    object.training_menus.joins(:training_sets).sum("training_sets.weight * training_sets.reps")
  end
end
