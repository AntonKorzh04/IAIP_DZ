require 'rails_helper'

RSpec.describe WorkoutController, type: :controller do
  # фабрики
  let(:user) { create(:user) } # пользователь
  let(:workout) { create(:workout, user: user) } # тренировка для пользователя
  
  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @workout_by_date_list" do
      get :index
      expect(assigns(:workout_by_date_list)).not_to be_nil
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates a new workout" do
      workout
      session[:current_workout_id] = workout.id
      post :create, params: { body_weight: workout.body_weight, workout_date: workout.date }
      expect(response).to redirect_to(workout_index_path)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: workout.id }, format: :json
      expect(response).to have_http_status(:success)
    end

    it "assigns @exercises" do
      get :show, params: { id: workout.id }, format: :json
      expect(assigns(:exercises)).not_to be_nil
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: workout.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @workout" do
      get :edit, params: { id: workout.id }
      expect(assigns(:workout)).to eq(workout)
    end
  end

  describe "PATCH #update" do
    it "updates the workout" do
      patch :update, params: { id: workout.id, workout: { body_weight: 75, date: Date.tomorrow } }
      expect(response).to redirect_to(workout_index_path)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the workout" do
      delete :destroy, params: { id: workout.id }
      expect(response).to redirect_to(workout_index_path)
    end
  end
end
