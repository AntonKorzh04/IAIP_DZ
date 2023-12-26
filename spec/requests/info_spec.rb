require 'rails_helper'

RSpec.describe InfoController, type: :controller do
  # фабрики
  let(:user) { create(:user) } # пользователь
  let(:workout) { create(:workout,  user: user) } # тренировка для пользователя
  let(:post) { create(:post, user: user, workout: workout) } # пост для пользователя и тренировки
  
  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

  before do
    sign_in user
  end

  describe "GET #news" do
    it "returns http success" do
      get :news
      expect(response).to have_http_status(:success)
    end

    it "assigns @news" do
      get :news
      expect(assigns(:news)).to eq([post])
    end

    it "assigns @workout_by_date_list" do
      workout
      get :news
      expect(assigns(:workout_by_date_list)).to eq([[workout.id, workout.date]])
    end
  end
end