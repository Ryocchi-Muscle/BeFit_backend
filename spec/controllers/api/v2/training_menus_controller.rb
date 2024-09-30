require 'rails_helper'

RSpec.describe Api::V2::TrainingMenusController, type: :controller do
  let(:user) { create(:user) } # ユーザーを作成
  let(:date) { Date.today } # テスト用の日付
  let!(:training_menu) { create(:training_menu, user: user, date: date) } # トレーニングメニューを作成

  before do
    allow(controller).to receive(:set_current_user).and_return(user) # ユーザーをセット
  end

  describe 'GET #index' do
    context 'when user is logged in' do
      it 'returns http success' do
        get :index, params: { user_id: user.id, date: date }
        expect(response).to have_http_status(:success)
      end

      it 'returns the training menus for the current user' do
        get :index, params: { user_id: user.id, date: date }
        json_response = JSON.parse(response.body)
        expect(json_response.first['id']).to eq(training_menu.id)
      end
    end
  end
end
