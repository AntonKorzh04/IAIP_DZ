class UserController < ApplicationController
  before_action :authenticate_user! 
  
  def view_profile
  end

  def get_email
    @user = User.find(params[:id])
    render json: { email: @user.email }
  end
  
end
