require 'rails_helper'

RSpec.describe PostController, type: :controller do
  # фабрики
  let(:user) { create(:user) } # пользователь
  let(:workout) { create(:workout,  user: user) } # тренировка для пользователя
  let(:user_post) { create(:post, user: user, workout: workout) } # пост для пользователя и тренировки
  
  before do
    sign_in user
  end

  describe "POST #create" do
    it "creates a new post" do
      user
      workout
      expect {
        post :create, params: { users_id: user.id, workouts_id: workout.id }
      }.to change(Post, :count).by(1)
    end

    it "redirects to info_news_path" do
      post :create, params: { users_id: user.id, workouts_id: workout.id }
      expect(response).to redirect_to(info_news_path)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      user_post
      expect {
        delete :destroy, params: { id: user_post.id }
      }.to change(Post, :count).by(-1)
    end

    it "redirects to info_news_path" do
      delete :destroy, params: { id: user_post.id }
      expect(response).to redirect_to(info_news_path)
    end
  end
end
