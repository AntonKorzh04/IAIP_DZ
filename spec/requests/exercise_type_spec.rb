require 'rails_helper'

RSpec.describe ExerciseTypeController, type: :controller do
    # фабрики
    let(:user) { create(:user) } # пользователь
    let(:exercise_type) { create(:exercise_type, user: user) } # тип упражнения для пользователя

    before do
        sign_in user
    end

    describe "GET #index" do
        it "renders the index template" do
            get :index
            expect(response).to render_template(:index)
        end

        it "assigns @exercise_types" do
            get :index
            expect(assigns(:exercise_types)).to eq([exercise_type])
        end
    end

    describe "GET new" do
        it "renders the new template" do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe "POST create" do
        it "creates a new exercise type" do
            post :create, params: { name: "New Exercise", description: "Description" }
            expect(response).to redirect_to(exercise_type_index_path)
            expect(ExerciseType.count).to eq(1)
        end
    end

    describe "GET edit" do
        it "renders the edit template" do
            get :edit, params: { id: exercise_type.id }
            expect(response).to render_template(:edit)
        end
    end

    describe "PUT update" do
        it "updates the exercise type" do
            put :update, params: { id: exercise_type.id, exercise_type: { name: "Updated Name", description: "Updated Description" } }
            expect(response).to redirect_to(exercise_type_index_path)
            exercise_type.reload
            expect(exercise_type.name).to eq("Updated Name")
            expect(exercise_type.description).to eq("Updated Description")
        end
    end

    describe "DELETE destroy" do
        it "destroys the exercise type" do
            delete :destroy, params: { id: exercise_type.id }
            expect(response).to redirect_to(exercise_type_index_path)
            expect(ExerciseType.count).to eq(0)
        end
    end
end
