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
end
