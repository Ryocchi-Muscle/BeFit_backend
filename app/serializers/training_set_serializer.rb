class TrainingSetSerializer < ActiveModel::Serializer
  attributes :id, :set_number, :weight, :reps, :completed, :training_menu_id


  def serializable_hash(adapter_options = nil, options = {}, adapter_instance = self.class.serialization_adapter_instance)
    hash = super
    Rails.logger.debug("Serialized TrainingSet: #{hash.inspect}")
    hash
  end
end
