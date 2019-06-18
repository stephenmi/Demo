class SessionsController < ApplicationController
	prepend_before_action :require_no_auth
  def new
  	@user = User.new
  end

  def create
  	@user = User.valid_login?(user_params)
  	if @user
  		session[:user_id] = @user.id
  		redirect_to root_path
  	else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  def edit
  end

  def destroy
  	if current_user
  		session.destroy
  	end
  end

  private

  def user_params
  	params.require(:user).permit(:email, :password)
  end
end
