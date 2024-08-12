require 'rails_helper'

RSpec.describe ProgramBundle, type: :model do
  let(:user) { create(:user) }

  it '有効な属性がすべて設定されている場合は有効であること' do
    program_bundle = ProgramBundle.new(gender: 'male', frequency: 3, duration: 4, user: user)
    expect(program_bundle).to be_valid
  end

  it 'genderがnilの時は無効になること' do
    program_bundle = ProgramBundle.new(gender: nil, frequency: 3, duration: 4, user: user)
    expect(program_bundle).not_to be_valid
    expect(program_bundle.errors[:gender]).to include("can't be blank")
  end

  it 'frequencyがnilの時は無効になること' do
    program_bundle = ProgramBundle.new(gender: 'male', frequency: nil, duration: 3, user: user)
    expect(program_bundle).not_to be_valid
    expect(program_bundle.errors[:frequency]).to include("can't be blank")
  end

  it 'durationがnilの時は無効になること' do
    program_bundle = ProgramBundle.new(gender: 'male', frequency: 3, duration: nil, user: user)
    expect(program_bundle).not_to be_valid
    expect(program_bundle.errors[:duration]).to include("can't be blank")
  end

  it 'user_idが一意でなければ無効であること' do
    ProgramBundle.create!(gender: 'male', frequency: 3, duration: 12, user: user)
    duplicate_program_bundle = ProgramBundle.new(gender: 'female', frequency: 5, duration: 8, user: user)
    expect(duplicate_program_bundle).not_to be_valid
    expect(duplicate_program_bundle.errors[:user_id]).to include("has already been taken")
  end

   it 'ユーザーと関連付けられていること' do
    program_bundle = ProgramBundle.new(gender: 'male', frequency: '3 times a week', duration: 12, user: user)
    expect(program_bundle.user).to eq(user)
  end

  it 'daily_programsが関連付けられており、dependent: :destroyが正しく動作すること' do
    program_bundle = ProgramBundle.create!(gender: 'male', frequency: 3,
    duration: 12, user: user)
    daily_program = program_bundle.daily_programs.create!(week: 1, day: 1)
    expect { program_bundle.destroy }.to change { DailyProgram.count }.by(-1)
  end

end
