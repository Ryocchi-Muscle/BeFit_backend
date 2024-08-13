require 'rails_helper'

RSpec.describe TrainingDay, type: :model do
  let(:user) { create(:user) }

  it '有効な属性が設定されている場合は有効であること' do
    training_day = TrainingDay.new(date: Date.today, user: user)
    expect(training_day).to be_valid
  end

  it 'dateがnilの場合は無効であること' do
    training_day = TrainingDay.new(date: nil, user: user)
    expect(training_day).not_to be_valid
    expect(training_day.errors[:date]).to include("can't be blank")
  end

  it '同じuser_idに対して同じdateが存在する場合は無効であること' do
    TrainingDay.create!(date: Date.today, user: user)
    duplicate_training_day = TrainingDay.new(date: Date.today, user: user)
    expect(duplicate_training_day).not_to be_valid
    expect(duplicate_training_day.errors[:date]).to include("has already been taken")
  end

    it 'ユーザーと関連付けられていること' do
    training_day = TrainingDay.new(date: Date.today, user: user)
    expect(training_day.user).to eq(user)
  end

  it 'training_menusが関連付けられており、dependent: :destroyが正しく動作すること' do
    training_day = TrainingDay.create!(date: Date.today, user: user)
    training_day.training_menus.create!(name: 'Squat', sets: 3)

    expect { training_day.destroy }.to change { TrainingMenu.count }.by(-1)
  end

   it 'nested attributes for training_menusが正しく保存されること' do
    training_day = TrainingDay.new(
      date: Date.today,
      user: user,
      training_menus_attributes: [{ name: 'Squat', sets: 3 }]
    )
    expect(training_day).to be_valid
    expect { training_day.save }.to change { TrainingMenu.count }.by(1)
  end
end
