class SmsRequestsController < ApplicationController
  # GET /sms_requests
  # GET /sms_requests.json
  before_filter :authenticate_user!
  load_and_authorize_resource
  def index
    @sms_requests = SmsRequest.paginate(:page => params[:page], :per_page => params[:size]? params[:size]:PAGE_SIZE )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sms_requests }
    end
  end

  # GET /sms_requests/1
  # GET /sms_requests/1.json
  def show
    @sms_request = SmsRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sms_request }
    end
  end

  # GET /sms_requests/new
  # GET /sms_requests/new.json
  def new
    @sms_request = SmsRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sms_request }
    end
  end

  # GET /sms_requests/1/edit
  def edit
    @sms_request = SmsRequest.find(params[:id])
  end

  # POST /sms_requests
  # POST /sms_requests.json
  def create
    @sms_request = SmsRequest.new(params[:sms_request])

    respond_to do |format|
      if @sms_request.save
        format.html { redirect_to @sms_request, notice: 'Sms request was successfully created.' }
        format.json { render json: @sms_request, status: :created, location: @sms_request }
      else
        format.html { render action: "new" }
        format.json { render json: @sms_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sms_requests/1
  # PUT /sms_requests/1.json
  def update
    @sms_request = SmsRequest.find(params[:id])

    respond_to do |format|
      if @sms_request.update_attributes(params[:sms_request])
        format.html { redirect_to @sms_request, notice: 'Sms request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sms_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_requests/1
  # DELETE /sms_requests/1.json
  def destroy
    @sms_request = SmsRequest.find(params[:id])
    @sms_request.destroy

    respond_to do |format|
      format.html { redirect_to sms_requests_url }
      format.json { head :no_content }
    end
  end
end
