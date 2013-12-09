class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    #current_user.update_column(:authentication_token, nil)
    #warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    #render :status => 200,
    #       :json => { :success => true,
    #                  :info => "Logged in",
    #                  :data => { :auth_token => current_user.authentication_token,:user=>current_user,
    #                             :role =>current_user.roles.first
    #                  }
    #
    #                }

    begin
      resource = User.find_first_by_auth_conditions(:login => params[:user][:login])
      if (!resource.nil?) && (resource.valid_password?(params[:user][:password]))
        resource.reset_authentication_token!
        sign_in(resource,  store: false)
        current_user.update_column(:is_login, true)
        #resource.save
        #TODO: set isOnline = true
        render :status => 200,
               :json => { :success => true,
                          :info => "Logged in",
                          :data => { :auth_token => current_user.authentication_token,:user=>current_user,
                                     :role =>current_user.roles.first
                          }

               }
        #render :status => 200,
        #       :json => {
        #           :success => true,
        #           :info => "Logged in",
        #           :data => {
        #               :auth_token => resource.authentication_token,
        #               :username => resource.username,
        #               :email => resource.email,
        #               :pending_contract => pending_contracts(resource)
        #           }
        #       }
      else
        render :status => 401,
               :json => { :success => false,
                          :info => "Wrong user name or password",
                          :data => {} }
      end
    end
end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    current_user.update_column(:authentication_token, nil)
    current_user.update_column(:is_login, false)
    #TODO: set isOnline = false
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged out",
                      :data => {} }
  end

  def failure
    render :status => 401,
           :json => { :success => false,
                      :info => "Wrong user name or password",
                      :data => {} }
  end
end