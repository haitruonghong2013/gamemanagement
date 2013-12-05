class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  before_filter :authenticate_user!
  load_and_authorize_resource
  def index

    #Logic push notification happen next 30 minutes
    push_notifications = PushNotification.all
    push_notifications.each do |push_notification|
      meetings = Meeting.where('status = 0 and user_id = :user_id and  updated_at <= :param1 and updated_at >= :param2',
                               :user_id => push_notification.user_id,
                               :param1 => Time.now + (push_notification.time_reminder/60 + 5).minutes,
                               :param2 => Time.now + (push_notification.time_reminder/60 - 5).minutes
      )
      meetings.each do |meeting|
        if push_notification.device_id
          APNS.send_notification(push_notification.device_id, :alert => "Next Meeting with client #{meeting.client.name} at #{meeting.meeting_time}",
                                               :badge => 1,
                                               :sound => 'default',
                                               :other => {:type => 1,
                                                          :meeting_id => meeting.id,
                                                          :client_id => meeting.client.id}
                                )
        end
      end
        #if meeting.user and meeting.user.push_notification and meeting.user.push_notification.device_id
        #  device_token = meeting.user.push_notification.device_id
        #else
        #  device_token = 'fce5197c11d5dbabb278240f56b2060e55b528076f24cedbf828c0d69ead7a6d'
        #end
    end


    #Logic push notification happen late 30 minutes
    #check time of next meeting and notify when time exceed 30 minutes but user not meeting
    #push_notifications = PushNotification.all
    #push_notifications.each do |push_notification|
    #  meetings = Meeting.where('status = 0 and user_id = :user_id and  updated_at <= :param1 and updated_at >= :param2',
    #                           :user_id => push_notification.user_id,
    #                           :param1 => Time.now - (push_notification.time_reminder/60 + 5).minutes,
    #                           :param2 => Time.now - (push_notification.time_reminder/60 - 5).minutes
    #  )
    #  meetings.each do |meeting|
    #    if push_notification.device_id
    #      APNS.send_notification(device_token, "meeting id #{meeting.id} late about 30 minutes" )
    #    end
    #  end
    #end

    #Logic push notification take note similar but after meeting done 30 minutes
    #push_notifications.each do |push_notification|
    #  meetings = Meeting.where("status ='complete' and user_id = :user_id and updated_at >= :param1 and updated_at <= :param2",
    #                           :user_id => push_notification.user_id,
    #                           param1 => Time.now - 33.minutes,
    #                           #param1 => Time.now - 33.minutes,
    #                           #param2 => Time.now - 28.minutes
    #                           param2 => Time.now - 28.minutes
    #  )
    #  meetings.each do |meeting|
    #    if push_notification.device_id
    #      device_token = push_notification.device_id
    #    else
    #      device_token = 'fce5197c11d5dbabb278240f56b2060e55b528076f24cedbf828c0d69ead7a6d'
    #    end
    #    APNS.send_notification(device_token, "meeting id #{meeting.id} late about 30 minutes" )
    #  end
    #end

    #posts = Post.where('updated_at <= :thirty_minutes',:thirty_minutes=>Time.now - 2.days)
    #posts.length
    #authorize! :index, Post, :message => 'Not authorized as an administrator.'
    @posts = Post.all
    #@posts = Post.where('updated_at >= :param1 and updated_at <= :param2',:param1 => Time.now - 33.minutes,:param2 => Time.now - 28.minutes)
    #@posts = Post.where('updated_at <= :thirty_minutes',:thirty_minutes => Time.now - 30.minutes)
        post = @posts.first
    #device_token = 'fce5197c11d5dbabb278240f56b2060e55b528076f24cedbf828c0d69ead7a6d'
    #
    #APNS.send_notification(device_token, 'Hello iPhone!' )
    #
    #APNS.send_notification(device_token, :alert => 'Hello iPhone!', :badge => 1, :sound => 'default')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    @post = Post.find(params[:id])
    #authorize! :update, @post, :message => 'Not authorized as an administrator.'
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    #authorize! :create, @post, :message => 'Not authorized as an administrator.'
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    #authorize! :update, @post, :message => 'Not authorized as an administrator.'
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    #authorize! :destroy, @post, :message => 'Not authorized as an administrator.'
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    Post.destroy(params[:blog_posts])
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
