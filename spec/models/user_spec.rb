require 'rails_helper'

RSpec.describe User, type: :model do
  describe "asociations" do
    it "has many training_days" do
     association = described_class.reflect_on_association(:training_days)
     expect(association.macro).to eq :has_many
    end

    it "has one program_bundle" do
      association = described_class.reflect_on_association(:program_bundle)
      expect(association.macro).to eq :has_one
    end
  end

  describe "dependent destroy" do
    it "destroy associated training_days when user is destroyed" do
      user = User.create!
      user.training_days.create!(date: Date.today)

      expect { user.destroy }.to change { TrainingDay.count }.by(-1)
    end

    it "destroy associated program_bundle when user is destroyed" do
      user = User.create!
      user.create_program_bundle!(gender: "male", frequency: 3, duration: 12)

      expect { user.destroy }.to change { ProgramBundle.count }.by(-1)
    end
  end
end
