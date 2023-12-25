class InfoController < ApplicationController
  before_action :authenticate_user!, except: :about
  
  def about
  end

  def news
    @news = Post.all
    @workout_by_date_list = Workout.all.pluck(:id, :date)
  end
end
