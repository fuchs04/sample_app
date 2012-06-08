class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  def  new
    @user = User.new
    @title = "Registrieren"
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Willkommen auf der Hochzeitsseite"
      redirect_to @user
    else
      @title = "Registrieren"
      render 'new'
    end
  end
end
