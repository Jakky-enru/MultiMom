class UsersController < ApplicationController
  def show
  end

  def edit

  end

  def update

  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
