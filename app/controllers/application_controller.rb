class ApplicationController < ActionController::Base
  #before_filter :set_timezone
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  #protect_from_forgery
  PAGE_SIZE = 10
  #after_filter :store_location


  def set_timezone
    Time.zone = current_user.time_zone if current_user
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/password" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    #redirect_to root_path, :alert => exception.message
    respond_to do |format|
      format.html {redirect_to root_path, :alert => exception.message}
      format.json { return render :status => 401, :json => {:success => false, :errors => [exception.message]} }
    end
  end


  def render_json_error_hash(status,json={})
    respond_to do |format|
      format.json {
        render :status => status,
               :json => json
      }
    end
  end


  def render_json_error_with_error_code(status, error_code, message='')
    respond_to do |format|
      format.json {
        render :status => status,
               :json => {
                   :success => false,
                   :info => message,
                   :error_code => error_code,
                   :data => {}
               }
      }
    end
  end

  def render_json_error(status, message)
    respond_to do |format|
      format.json {
        render :status => status,
               :json => {
                   :success => false,
                   :info => message,
                   :data => {}
               }
      }
    end
  end

  layout :layout

  private

  def layout
    # only turn it off for login pages:
    is_a?(Devise::SessionsController) ? false : "application"
    # or turn layout off for every devise controller:
    #devise_controller? && "application"
  end

end
