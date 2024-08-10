require 'rails_helper'

Rspec.describe User, type: :model do
  describe "asociations" do
    it "has many training_days" do
     association = described_class.reflect_on_association(:training_days)
     expect(association.marco).to eq :has_many
    end

    it "has one program_bundle" do
      association = describe_class.reflect_on_association(:program_bundle)
      expect(association.marco).to eq :has_one
    end
  end

  describe "dependent destroy" do
    it "destroy associated training_days when use is destroyed" do
      user = User.create!
      user.training_days.create!

      expect { user.destroy }.to change { TrainingDay.count }.by(-1)
    end

    it "destroy associated program_bundle when user is destroyed" do
      user = User.create!
      user.create_program_bundle!

      expect { user.destroy }.to chenge { ProgramBUndle.count }.by(-1)
    end
  end
end
