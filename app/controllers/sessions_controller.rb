class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Welcome, you are logged in.'
    else
      flash[:alert] = 'Something wrong with username or password.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'You have logged out.'
  end
end