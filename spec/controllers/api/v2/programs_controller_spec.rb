require 'rails_helper'

RSpec.describe Api::V2::ProgramsController, type: :controller do
  let(:user) { create(:user) }
  let(:program_bundle) { create(:program_bundle, user: user) }

  before do
    allow(controller).to receive(:set_current_user).and_return(user)
  end

  describe "GET #index" do
    context "when user has a program_bundle" do
      before { user.program_bundle = program_bundle }

      it "returns the program_bundle with status 200" do
        get :index
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['program']).to eq(program_bundle.as_json)
      end
    end

    context "when user has no program_bundle" do
      it "returns an empty program with status 200" do
        get :index
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['program']).to be_nil
      end
    end
  end

  describe "POST #create" do
    let(:valid_program_bundle_params) do
      {
        program_bundle: {
          gender: "male",
          frequency: 3,
          week: 12
        },
        details: [
          { menu: "Squat", set_info: "3x10", week: 1, day: 1 },
          { menu: "Bench Press", set_info: "3x10", week: 1, day: 2 }
        ]
      }
    end

    context "when user has no existing program_bundle" do
      it "creates a new program_bundle and returns status 201" do
        expect {
          post :create, params: valid_program_bundle_params
        }.to change(ProgramBundle, :count).by(1)

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response['success']).to be true
      end
    end

    context "when user already has a program_bundle" do
      before { user.program_bundle = program_bundle }

      it "does not create a new program_bundle and returns status 422" do
        post :create, params: valid_program_bundle_params
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Program_bundle already exists")
      end
    end
  end

  describe "DELETE #destroy" do
    context "when program_bundle exists" do
      before { user.program_bundle = program_bundle }

      it "deletes the program_bundle and returns status 200" do
        expect {
          delete :destroy
        }.to change(ProgramBundle, :count).by(-1)

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
