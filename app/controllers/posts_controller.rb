class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  #before_filter :authenticate_user!
  caches_action :index, :show
  def index
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
        expire_action action:[:index] #expire the cache whenever a new article is posted
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
        expire_action action:[:index,:show] #expire the cache whenever a new article is posted
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
    expire_action action:[:index,:show] #expire the cache whenever a new article is posted
    #authorize! :destroy, @post, :message => 'Not authorized as an administrator.'
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    Post.destroy(params[:blog_posts])
    expire_action action:[:index,:show] #expire the cache whenever a new article is posted
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def list_game_play

  end
end
