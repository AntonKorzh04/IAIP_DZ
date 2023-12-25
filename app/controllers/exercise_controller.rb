class ExerciseController < ApplicationController
    before_action :authenticate_user!

    def new
    end

    # создание нового сделанного упражнения
    def create
        @exercise = Exercise.new(exercise_types_id: params[:exercise_type_id],
                                 comments: params[:comments],
                                 sets: params[:sets],
                                 workouts_id: session[:current_workout_id])
        @exercise.save
    end

    # изменение упражнения по данному id
    def edit
        @exercise = Exercise.find(params[:id])
        @exercise_types = ExerciseType.where(users_id: current_user.id).pluck(:name, :id, :description)

        # добавление к названию упражнения описания (при наличии)
        @exercise_types = @exercise_types.map { |arr|
            if arr[2].empty?
                [arr[0].to_s, arr[1]]
            else
                ["#{arr[0]} (#{arr[2]})", arr[1]]
            end
        }
    end

    def update
        @exercise = Exercise.find(params[:id])
        @exercise.update(exercise_types_id: params[:exercise][:exercise_types_id],
                         comments: params[:exercise][:comments],
                         sets: params[:sets])
    end

    # удаление упражнения
    def destroy
        @exercise = Exercise.find(params[:id])
        @exercise.destroy
    end
end
