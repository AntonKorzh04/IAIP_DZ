require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /view_profile" do
    it "returns http success" do
      get "/user/view_profile"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new_workout" do
    it "returns http success" do
      get "/user/new_workout"
      expect(response).to have_http_status(:success)
    end
  end

end
