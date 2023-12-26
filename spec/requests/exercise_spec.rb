require 'rails_helper'

RSpec.describe ExerciseController, type: :controller do
    # фабрики
    let(:user) { create(:user) } # пользователь
    let(:exercise_type) { create(:exercise_type, user: user) } # тип упражнения для пользователя
    let(:workout) { create(:workout,  user: user) } # тренировка для пользователя
    let(:exercise) { create(:exercise, workout: workout, exercise_type: exercise_type) } # упражнения для тренировки с типом

    before do
        sign_in user
    end

    describe "POST #create" do
        it "creates a new exercise" do
            post :create, params: { exercise_type_id: exercise.exercise_type_id, comments: exercise.comments, sets: exercise.sets }
            expect(response).to have_http_status(:success)
            expect(Exercise.count).to eq(1)
        end
    end

    describe "GET #edit" do
        it "returns http success" do
            get :edit, params: { id: exercise.id }
            expect(response).to have_http_status(:success)
        end
    end

    describe "PATCH #update" do
        it "updates the exercise" do
            patch :update, params: { id: exercise.id, exercise: { exercise_type_id: exercise.exercise_type_id,
                                                                  comments: 'new_comments' }, sets: 'new_sets' }
            expect(response).to have_http_status(:success)
            exercise.reload
            expect(exercise.comments).to eq('new_comments')
            expect(exercise.sets).to eq('new_sets')
        end
    end

    describe "DELETE #destroy" do
        it "destroys the exercise" do
            delete :destroy, params: { id: exercise.id }
            expect(response).to have_http_status(:success)
            expect(Exercise.count).to eq(0)
        end
    end
end
