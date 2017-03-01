class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
  	user = User.new(user_params)
  	if !user.valid?
  		@user = user
  		return render 'new'
  	end
  	user.save
  	session[:logged_in_as] = user.id
  	redirect_to '/shoes'
  end

  def login
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		session[:logged_in_as] = user.id
  		redirect_to '/shoes'
  	else
  		redirect_to '/main'
  	end
  end

  def logout
  	session[:logged_in_as] = nil
  	redirect_to '/main'
  end

  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
