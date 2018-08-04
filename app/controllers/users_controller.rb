class UsersController < ApplicationController

def sign_in
  @user = User.new
end

def login
  @user = User.find_by_name(params[:user][:name])
  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    flash[:notice] = "Welcome."
    redirect_to controller: 'tasks', action: 'index'
  else
    flash.now[:error] = 'Unknown user. Please check your username and password.'
    render :action => "sign_in"
  end
end

def new_user
  @user = User.new
end

def register
  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    flash[:notice] = 'Welcome.'
    redirect_to @user
  else
    render :action => "new_user"
  end
end

def show
  @user = User.find(params[:id])
end

def edit
  @user = User.new
end

def update
  respond_to do |format|
    if @user.update(user_params)
      redirect_to @user, notice: t(".success")
      render :show, status: :ok, location: @user
    else
      render :edit
    end
  end
end


def signed_out
  session[:user_id] = nil
  flash[:notice]  = "You have been signed out."
end
private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
