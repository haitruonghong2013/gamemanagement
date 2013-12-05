class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :authenticate_user!
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  def index
    if current_user.has_role? :admin
      @users = User.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => params[:size]? params[:size]:PAGE_SIZE )
    elsif current_user.has_role? :businessOwner
      @users = User.search(params[:search]).joins(:roles).where('users.organization_id = ? and roles.name not in (?)',current_user.organization_id, ['admin']).paginate(:page => params[:page], :per_page => params[:size]? params[:size]:PAGE_SIZE )
    elsif current_user.has_role? :saleLeader
      @users = User.search(params[:search]).joins(:roles).where('users.organization_id = ? and roles.name not in (?)',current_user.organization_id, ['admin','businessOwner']).paginate(:page => params[:page], :per_page => params[:size]? params[:size]:PAGE_SIZE )
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.js # index.js.erb
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    #@user.organization = Organization.new
    @organization_collections = Organization.all.append(Organization.new(:id =>'-1',:name =>'Other'))

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @organization_collections = Organization.all.append(Organization.new(:id =>'-1',:name =>'Other'))
    #reset organization name
    @user.organization.name = ''

    #if params[:user] and params[:user][:organization_id]
    #  @selected_organization_id = params[:user][:organization_id]
    #  if @selected_organization_id.to_i == -1
    #    @user.organization = Organization.new
    #  end
    #end


    #@selected_organization_id = @user.organization_id
    #if @user.organization.nil?
    #  #@user.organization = Organization.new
    #end


  end

  # POST /users
  # POST /users.json
  def create
    @organization_collections = Organization.all.append(Organization.new(:id =>'-1',:name =>'Other'))
    @selected_organization_id = params[:user][:organization_id]
    #@user = User.new(params[:user].except(:new_organization_name))
    @user = User.new(params[:user])
    if !current_user.has_role? :admin
      @user.organization_id = current_user.organization_id
    else
      if params[:user][:organization_id] != '-1'
        #organization_obj = Organization.find_by_name(params[:user][:organization_attributes][:name])
        organization_obj = Organization.find(params[:user][:organization_id])
        if organization_obj
          @user.organization_id = organization_obj.id
        end
      #elsif params[:new_organization_name]
      #  elsif params[:user][:organization_attributes][:name]
        #new_organization = Organization.new
        ##new_organization.name = params[:new_organization_name]
        #new_organization.name =  params[:user][:organization_attributes][:name]
        ##new_organization.save
        #@user.organization = new_organization
      end
    end
    #if params[:user][:role_ids] == nil
    #  #salestaff id
    #  params[:user][:role_ids] = Role.find_by_name(:saleStaff).id
    #else
    #  role = Role.find(params[:user][:role_ids])
    #
    #  #if role and role.name == 'businessOwner'
    #  #  #assign user role
    #  #  @user.organization = Organization.new
    #  #  @user.organization.name = params[:user][:username]
    #  #else
    #  #  #Todo: add organization_id of created by user
    #  #  @user.organization_id = 1
    #  #end
    #end


    #@user.add_role :admin
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @organization_collections = Organization.all.append(Organization.new(:id =>'-1',:name =>'Other'))
    if params[:user] and params[:user][:organization_id]
      @selected_organization_id = params[:user][:organization_id]
      if @selected_organization_id.to_i == -1
        @user.organization = Organization.new
      end
    end
    @user = User.find(params[:id])
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end
    @user.assign_attributes(params[:user].except(:organization_attributes))
    if !current_user.has_role? :admin
      @user.organization_id = current_user.organization_id
    else
      if params[:user][:organization_id] != '-1'
        organization_obj = Organization.find(params[:user][:organization_id])
        if organization_obj
          @user.organization_id = organization_obj.id
        end
      else
        #TODO:bug here
        #organization = Organization.new
        #organization.name = params[:user][:organization_attributes][:name]
        #if organization.save
        #  @user.organization_id = organization.id
        #end
        @user.organization = Organization.new
        @user.organization.name = params[:user][:organization_attributes][:name]
      end
     end







    respond_to do |format|
      #if @user.update_attributes(params[:user].except(:organization_attributes))
      if @user.save
          format.html { redirect_to users_url, :notice=> 'User was successfully updated.'}
          format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "username"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
