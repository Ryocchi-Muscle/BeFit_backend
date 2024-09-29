require 'rails_helper'

RSpec.describe Api::V2::PersonalizedMenusController, type: :controller do
  let(:user) { create(:user) }
  let(:program_bundle) { create(:program_bundle, user: user) }

  before do
    allow(controller).to receive(:set_current_user).and_return(user)
  end

  describe "GET #index" do
    context "when user has a program_bundle" do
      before { user.program_bundle = program_bundle }

      it "returns the program_bundle with associated daily_programs and training_menus with status 200" do
        get :index
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['program']).to eq(program_bundle.as_json(include: {
          daily_programs: {
            include: :training_menus,
            except: [:created_at, :updated_at]
          }
        }))
      end
    end

    context "when user has no program_bundle" do
      it "returns nil for program with status 200" do
        get :index
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['program']).to be_nil
      end
    end
  end

  describe "POST #create_and_save" do
    let(:valid_program_params) do
      {
        gender: "male",
        frequency: 3,
        duration: 12
      }
    end

    context "when user has no existing program_bundle" do
      it "creates a new program_bundle and returns status 201" do
        expect {
          post :create_and_save, params: valid_program_params
        }.to change(ProgramBundle, :count).by(1)

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response['program']).not_to be_nil
      end
    end

    context "when user already has a program_bundle" do
      before { user.program_bundle = program_bundle }

      it "does not create a new program_bundle and returns status 422" do
        post :create_and_save, params: valid_program_params
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq("プログラムバンドルは既に存在します")
      end
    end
  end

  describe "PATCH #update" do
    let(:daily_program) { create(:daily_program, program_bundle: program_bundle) }
    let(:valid_update_params) do
      {
        id: daily_program.id,
        details: [
          {
            menuName: "Squat",
            sets: [
              { setNumber: 1, reps: 10, weight: 60 },
              { setNumber: 2, reps: 8, weight: 65 }
            ]
          }
        ]
      }
    end

    context "when updating existing daily_program" do
      it "updates the daily_program and returns status 200" do
        patch :update, params: valid_update_params
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['id']).to eq(daily_program.id)
      end
    end

    context "when daily_program does not exist" do
      it "returns status 404" do
        patch :update, params: { id: -1, details: valid_update_params[:details] }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when program_bundle exists" do
      before { user.program_bundle = program_bundle }

      it "deletes the program_bundle and all associated training days and returns status 200" do
        training_days = create_list(:training_day, 3, user: user)
        expect {
          delete :destroy
        }.to change(ProgramBundle, :count).by(-1).and change(TrainingDay, :count).by(-3)

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be true
      end
    end

    context "when program_bundle does not exist" do
      it "returns status 404" do
        delete :destroy
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Program_bundle not found")
      end
    end
  end
end
