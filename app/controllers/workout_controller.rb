require 'json'

class WorkoutController < ApplicationController
    before_action :authenticate_user!

    # просмотреть все тренировки
    def index
        # получаю список всех тренировок с id и датой для текущего юзера
        @workout_by_date_list = Workout.where(user_id: current_user.id).pluck(:id, :date, :user_id)
    end

    # создание новой тренировки
    def new
        @workout = Workout.new(user_id: current_user.id, date: Date.today)
        @workout.save
        session[:current_workout_id] = @workout.id
        @exercise_types = ExerciseType.where(user_id: current_user.id).pluck(:name, :id, :description)
        
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
        @exercises = Exercise.where(workout_id: params[:id])

        formatted_exercises = @exercises.map.with_index do |exercise, index|
            {
                "id" => exercise.id,
                "created_at" => exercise.created_at,
                "exercise_number" => index + 1,
                "exercise_type_name" => ExerciseType.find(exercise.exercise_type_id).name,
                "exercise_type_description" => ExerciseType.find(exercise.exercise_type_id).description,
                "sets" => exercise.sets,
                "comments" => exercise.comments
            }
        end

        sorted_exercises = formatted_exercises.sort_by { |exercise| exercise["created_at"] }

        respond_to do |format|
            format.json { render json: sorted_exercises }
        end
    end

    def edit
        @workout = current_user.workouts.find_by(id: params[:id]) # Поиск тренировки только среди тренировок текущего пользователя
      
        if @workout
          session[:current_workout_id] = @workout.id
          @exercise_types = ExerciseType.where(user_id: current_user.id).pluck(:name, :id, :description)
          
          # добавление к названию упражнения описания (при наличии)
          @exercise_types = @exercise_types.map do |arr|
            if arr[2].empty?
              [arr[0].to_s, arr[1]]
            else
              ["#{arr[0]} (#{arr[2]})", arr[1]]
            end
          end
        else
          # Если тренировка не найдена или принадлежит другому пользователю
          redirect_to workout_index_path, alert: "У вас нет прав для редактирования этой тренировки."
        end
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
        @exercises = Exercise.where(workout_id: params[:id])
        @exercises.destroy_all
        @workout.destroy
        redirect_to workout_index_path
    end
end
