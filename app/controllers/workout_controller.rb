require 'json'

class WorkoutController < ApplicationController
    before_action :authenticate_user!

    # просмотреть все тренировки
    def index
        @workout_by_date_list = Workout.all.pluck(:id, :date, :users_id) # получаю список всех тренировок с id и датой
    end

    # создание новой тренировки
    def new
        @workout = Workout.new(users_id: current_user.id, date: Date.today)
        @workout.save
        session[:current_workout_id] = @workout.id
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

    def create
        @workout = Workout.find(session[:current_workout_id])
        if @workout.update(body_weight: params[:body_weight], date: params[:workout_date])
            redirect_to workout_index_path
        else
            render :new
        end
    end

    # просмотр упражнений за данную тренировку
    def show
        @exercises = Exercise.where(workouts_id: params[:id])

        formatted_exercises = @exercises.map.with_index do |exercise, index|
            {
                "id" => exercise.id,
                "created_at" => exercise.created_at,
                "exercise_number" => index + 1,
                "exercise_type_name" => ExerciseType.find(exercise.exercise_types_id).name,
                "exercise_type_description" => ExerciseType.find(exercise.exercise_types_id).description,
                "sets" => exercise.sets,
                "comments" => exercise.comments
            }
        end

        sorted_exercises = formatted_exercises.sort_by { |exercise| exercise["created_at"] }

        respond_to do |format|
            format.json { render json: sorted_exercises }
        end
    end

    # изменение тренировки по данному id
    def edit
        @workout = Workout.find(params[:id])
        session[:current_workout_id] = @workout.id
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
        @workout = Workout.find(params[:id])
        if @workout.update(body_weight: params[:workout][:body_weight], date: params[:workout][:date])
            redirect_to workout_index_path
        else
            render :edit
        end
    end

    # удаление тренировки
    def destroy
        @workout = Workout.find(params[:id])
        @exercises = Exercise.where(workouts_id: params[:id])
        @exercises.destroy_all
        @workout.destroy
        redirect_to workout_index_path
    end
end
