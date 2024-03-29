class SessionsController < ApplicationController
  def new
    redirect_to categories_path if signed_in?
  end

  def create
    user = User.find_by email: params[:session][:email]
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = 'Successfully signed in'
      redirect_to categories_path
    elsif user.nil?
      flash.now[:error] = 'Unknown email address!'
      render :new
    else
      flash.now[:error] = 'Incorrect password!'
      render :new
    end
  end

  def destroy
    sign_out
    flash[:success] = 'Signed out successfully'
    redirect_to signin_path
  end
end
