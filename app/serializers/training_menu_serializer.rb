class TrainingMenuSerializer < ActiveModel::Serializer
  attributes :id, :exercise_name, :set_info, :daily_program_id
  has_many :training_sets

  def serializable_hash(adapter_options = nil, options = {}, adapter_instance = self.class.serialization_adapter_instance)
    hash = super
    Rails.logger.debug("Serialized TrainingMenu: #{hash.inspect}")
    hash
  end
end
