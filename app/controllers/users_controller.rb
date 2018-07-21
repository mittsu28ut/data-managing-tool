class UsersController < ApplicationController

def sign_in
  @user = User.new
end

def login
  @user = User.find_by_name(params[:user][:name])
  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    flash[:notice] = "Welcome."
    redirect_to :root
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
    redirect_to :root
  else
    render :action => "new_user"
  end
end

def account_settings
  @user = current_user
end

def set_account_info
  old_user = current_user
  #verify the current password by creating a new user record.
  @user = User.find_by_name old_user.name
  if @user && @user.authenticate(params[:password])
    #update the user with any new username and email
    @user.update(params[:user])
    #Set the old email and username, which is validated only if it has changed.
    @user.previous_email = old_user.email
    @user.previous_name = old_user.name
    if @user.valid?
      #if there is a new_password value, then we need to update the password/
      @user.password = @user.new_password unless @user.new_password.nil? || @user.new_password.empty?
      @user.save
      flash[:notice] = "Account settings have been changed."
      redirect_to :root
    else
      render :action => "account_settings"
    end
  else
    @user = current_user
    @user.errors[:password] = "Password is incorrect."
    render :action => "account_settings"
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
