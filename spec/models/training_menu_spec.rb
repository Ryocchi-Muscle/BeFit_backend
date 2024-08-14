require 'rails_helper'

RSpec.describe TrainingMenu, type: :model do
  let(:training_day) { create(:training_day) }
  let(:daily_program) { create(:daily_program) }

  it '有効な属性が設定されている場合は有効であること' do
     training_menu = TrainingMenu.new(exercise_name: 'Squat', training_day: training_day, daily_program: daily_program)
    expect(training_menu).to be_valid
  end
end
