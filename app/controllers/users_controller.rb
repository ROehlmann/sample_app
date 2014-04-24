class UsersController < ApplicationController
  before_action :non_signed_in_user,  only: [:new, :create]
  before_action :signed_in_user,      only: [:index, :edit, :update, :destroy]
  before_action :correct_user,        only: [:edit, :update]
  before_action :admin_user,          only: :destroy 

  def index
    @users = User.paginate(page: params[:page])
    # params[:page] is generated automatically by will_paginate (in the view?)
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params) 
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
  	  redirect_to @user # user_url can be omitted.
  	else
  	  render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    victim = User.find(params[:id])
    unless current_user?(victim)
      victim.destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    else
      redirect_to root_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def non_signed_in_user
      if signed_in?
        redirect_to root_url, notice: "You already have an account."
      end 
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end







