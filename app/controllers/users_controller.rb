class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :club, :show]
  before_action :correct_user, only: [:edit, :update]

  def home
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params[:user][:email],
                     password: params[:user][:password],
                     password_confirmation: params[:user][:password],
                     first_name: params[:user][:first_name],
                     last_name: params[:user][:last_name])
    if @user.valid?
      @user.save
      log_in(@user)
      flash[:success] = "Bienvenue ma men!"
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email (empty or already taken)'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(first_name: params[:user][:first_name],
                 last_name: params[:user][:last_name],
                 email: params[:user][:email],
                 password: params[:user][:password],
                 password_confirmation: params[:user][:password])
    redirect_to user_path id: @user.id
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to '/'
  end

  private

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:danger] = "You don't have the rights to do this, please log in again"
      redirect_to(root_url)
    end
  end
end
