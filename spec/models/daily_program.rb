require 'rails_helper'

Rspec.describe DailyProgram, type: :model do
  let(:program_bundle) { create(:program_bundle) }

  it '有効な属性が設定されている場合は有効であること' do
    daily_program = DailyProgmram.new(week: 1, day: 1, program_bundle: program_bundle)
    expect(daily_program).to be_valid
  end

  it 'weekがnilの場合は無効であること' do
    daily_program = DailyProgram.new(week: nil, day: 1, program_bundle: program_bundle)
    expect(daily_program).not_to be_valid
    expect(daily_program.errors[:week]).to include("cant't be blank")
  end

  it 'dayがnilの場合は無効であること' do
    daily_program = DailyProgram.new(week: 1, day: nil, program_bundle: program_bundle)
    expect(daily_program).not_to be_valid
    expect(daily_program.errors[:day]).to include("can't be blank")
  end

  it 'dayが整数でない場合は無効になること'do
  daily_program = DailyProgram.new(week: 1,day: 'a', program_bundle: program_bundle)
  expect(daily_program).not_to be_valid
  expect(daily_program.errors[:day]).to include("is not a number")
 end

 it 'dayが0以下の場合は無効であること' do
  daily_program = DailyProgram.new(week: 1,day: 'a', program_bundle: program_bundle)
  expect(daily_program).not_to be_valid
  expect(daily_program.errors[:day]).to include("is not a number")
 end
end
