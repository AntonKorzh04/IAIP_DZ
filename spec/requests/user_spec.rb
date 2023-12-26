require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET #view_profile" do
    it "returns http success" do
      get :view_profile
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #get_email" do
    it "returns user email as JSON" do
      get :get_email, params: { id: user.id }, format: :json
      json_response = JSON.parse(response.body)
      expect(json_response["email"]).to eq(user.email)
    end
  end
end
