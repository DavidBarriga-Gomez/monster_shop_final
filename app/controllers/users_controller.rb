class UsersController < ApplicationController
  def new
    @user = User.new(user_params)
  end

  def show
    @user = current_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name}, you are now registered and logged in."
      redirect_to "/profile"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    #require "pry"; binding.pry
    # user.update_attributes(update_user_params)
    require "pry"; binding.pry
    if user.update(user_params)
      flash[:success] = "Your information has been updated."
      redirect_to profile_path
    else
      flash[:notice] = user.errors.full_messages.to_sentence + ". Please fill out all required fields."
      @user = current_user
      render :edit
    end
  end

  private
    def user_params
      params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
    end

    def update_user_params
      params.permit(:name, :address, :city, :state, :zip, :email)
    end
end
