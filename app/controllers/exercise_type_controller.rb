class ExerciseTypeController < ApplicationController
    before_action :authenticate_user!

    # просмотреть все упражнения данного юзера
    def index
        @exercise_types = ExerciseType.where(users_id: current_user.id)
        
        # все упражнения, используемые в тренировках
        @exercise_types_used = ExerciseType.where(id: Exercise.pluck(:exercise_types_id).flatten.uniq, users_id: current_user.id)
    end

    # создание нового типа упражнений
    def new
    end

    def create
        @exercise = ExerciseType.new(name: params[:name], description: params[:description], users_id: current_user.id)
        if @exercise.save
            redirect_to exercise_type_index_path, notice: 'Упражнение успешно добавлено!'
        else
            render :new
        end
    end

    # изменение упражнения по данному id
    def edit
        @exercise = ExerciseType.find(params[:id])
    end

    def update
        @exercise = ExerciseType.find(params[:id])
        if @exercise.update(name: params[:exercise_type][:name], description: params[:exercise_type][:description])
            redirect_to exercise_type_index_path
        else
            render :edit
        end
    end

    # удаление упражнения
    def destroy
        @exercise = ExerciseType.find(params[:id])
        @exercise.destroy
        redirect_to exercise_type_index_path
    end
end
