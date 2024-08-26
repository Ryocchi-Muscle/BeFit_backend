require 'rails_helper'

RSpec.describe TrainingProgram, type: :model do
  let(:user) { create(:user) }
  describe 'バリデーションのテスト' do
    it '有効な属性が設定されている場合は有効であること' do
      training_program = TrainingProgram.new(user: user)
      expect(training_program).to be_valid
    end

    it 'userが存在しない場合は無効であること' do
      training_program = TrainingProgram.new(user: nil)
      expect(training_program).not_to be_valid
      expect(training_program.errors[:user]).to include("must exist")
    end
  end

  describe '関連付けのテスト' do
    it 'ユーザーと関連付けられていること' do
      training_program = TrainingProgram.new(user: user)
      expect(training_program.user).to eq(user)
    end

    it 'training_menusが関連付けられており、dependent: :destroyが正しく動作すること' do
      training_program = TrainingProgram.create!(user: user)
      training_program.training_menus.create!(exercise_name: 'Squat', sets: 3)

      expect { training_program.destroy }.to change { TrainingMenu.count }.by(-1)
    end
  end

    describe 'スコープテスト' do
    let(:male_program) { create(:training_program, gender: 'male', user: user) }
    let(:female_program) { create(:training_program, gender: 'female', user: user) }

    it 'by_genderスコープが正しく動作すること' do
      expect(TrainingProgram.by_gender('male')).to include(male_program)
      expect(TrainingProgram.by_gender('male')).not_to include(female_program)
    end

    let(:high_frequency_program) { create(:training_program, frequency: '5 times a week', user: user) }
    let(:low_frequency_program) { create(:training_program, frequency: '2 times a week', user: user) }

    it 'by_frequencyスコープが正しく動作すること' do
      expect(TrainingProgram.by_frequency('5 times a week')).to include(high_frequency_program)
      expect(TrainingProgram.by_frequency('5 times a week')).not_to include(low_frequency_program)
    end

    let(:short_duration_program) { create(:training_program, week: 4, user: user) }
    let(:long_duration_program) { create(:training_program, week: 12, user: user) }

    it 'by_durationスコープが正しく動作すること' do
      expect(TrainingProgram.by_duration(4)).to include(short_duration_program)
      expect(TrainingProgram.by_duration(4)).not_to include(long_duration_program)
    end
  end

end
