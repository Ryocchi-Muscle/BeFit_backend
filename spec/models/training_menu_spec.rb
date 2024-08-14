require 'rails_helper'

RSpec.describe TrainingMenu, type: :model do
  let(:training_day) { create(:training_day) }
  let(:daily_program) { create(:daily_program) }

  it '有効な属性が設定されている場合は有効であること' do
     training_menu = TrainingMenu.new(exercise_name: 'Squat', training_day: training_day, daily_program: daily_program)
    expect(training_menu).to be_valid
  end

  it 'exercise_nameがnilの場合は無効であること' do
    training_menu = TrainingMenu.new(exercise_name: nil, training_day: training_day, daily_program: daily_program)
    expect(training_menu).not_to be_valid
    expect(training_menu.errors[:exercise_name]).to include("can't be blank")
  end

  it 'training_dayがnilの場合は無効であること' do
    training_menu = TrainingMenu.new(exercise_name: 'Squat', training_day: nil, daily_program: nil)
    expect(training_menu).not_to be_valid
    expect(training_menu.errors[:training_day]).to include("can't be blank")
  end

  it 'training_dayがnilでもdaily_programが存在する場合は有効であること' do
    training_menu = TrainingMenu.new(exercise_name: 'Squat', training_day: nil, daily_program: daily_program)
    expect(training_menu).to be_valid
  end

  it 'training_dayと関連付けられていること' do
    training_menu = TrainingMenu.new(exercise_name: 'Squat', training_day: training_day, daily_program: daily_program)
    expect(training_menu.training_day).to eq(training_day)
  end
end
