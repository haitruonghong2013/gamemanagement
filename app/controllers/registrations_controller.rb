class RegistrationsController < Devise::RegistrationsController
  def update
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end


  def register
    tmp =  validate_register_param

    if tmp[:result] == false
      render_json_error_with_error_code(tmp[:status_code], tmp[:error_code], tmp[:message])
      return
    end

    @user = User.new(params[:user])
    @user.email = @user.username + 'example.com'
    @user.add_role :normalUser
    respond_to do |format|
      if @user.save(:validate => false)
        format.json {
          render :status => 201,
                 :json => {
                     :success => true,
                     :info => 'Created',
                     :data => {
                         :username => @user.username,
                         :auth_token => @user.authentication_token
                     }
                 }
        }
      else
        format.json {
          render :status => 409,
                 :json => {
                     :success => false,
                     :info => 'Create Failed',
                     :data => @user.errors
                 }
        }
      end
    end
  end

  private
  def validate_register_param
    #if params[:user][:email].strip.blank?
    #  return { :result => false, :error_code => 16, :status_code => 409 }
    #end
    if params[:user][:username].strip.blank?
      return { :result => false, :error_code => 17, :status_code => 409 }
    end
    if params[:user][:password].strip.length < 1
      return { :result => false, :error_code => 12, :status_code => 409 }
    end
    if params[:user][:password].strip.length != params[:user][:password_confirmation].strip.length
      return { :result => false, :error_code => 15, :status_code => 409 }
    end
    #if User.find_by_email(params[:user][:email])
    #  return { :result => false, :error_code => 13, :status_code => 409 }
    #end
    if User.find_by_username(params[:user][:username])
      return { :result => false, :error_code => 14, :status_code => 409, :message=>"username exists!" }
    end
    return {:result => true}
  end
end