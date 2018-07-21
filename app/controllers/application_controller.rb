class ApplicationController < ActionController::Base
  before_action :set_locale
  helper_method :current_user

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale)?
      locale :
      I18n.default_locale
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  protected
    def login_required
      return true if User.find_by_id(session[:user_id])
      access_denied
      return false
    end
    def access_denied
      flash[:error] = 'Oops. You need to login before you can view that page.'
      redirect_to :log_in
    end
  end
