class CharacterBotsController < ApplicationController
  # GET /character_bots
  # GET /character_bots.json
  before_filter :authenticate_user!
  load_and_authorize_resource
  def index
    @character_bots = CharacterBot.paginate(:page => params[:page], :per_page => params[:size]? params[:size]:PAGE_SIZE )

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @character_bots }
    end
  end

  # GET /character_bots/1
  # GET /character_bots/1.json
  def show
    @character_bot = CharacterBot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @character_bot }
    end
  end

  # GET /character_bots/new
  # GET /character_bots/new.json
  def new
    @character_bot = CharacterBot.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @character_bot }
    end
  end

  # GET /character_bots/1/edit
  def edit
    @character_bot = CharacterBot.find(params[:id])
  end

  # POST /character_bots
  # POST /character_bots.json
  def create
    @character_bot = CharacterBot.new(params[:character_bot])

    respond_to do |format|
      if @character_bot.save
        format.html { redirect_to @character_bot, notice: 'Character bot was successfully created.' }
        #format.json { render json: @character_bot, status: :created, location: @character_bot }
      else
        format.html { render action: "new" }
        #format.json { render json: @character_bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /character_bots/1
  # PUT /character_bots/1.json
  def update
    @character_bot = CharacterBot.find(params[:id])

    respond_to do |format|
      if @character_bot.update_attributes(params[:character_bot])
        format.html { redirect_to @character_bot, notice: 'Character bot was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @character_bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /character_bots/1
  # DELETE /character_bots/1.json
  def destroy
    @character_bot = CharacterBot.find(params[:id])
    @character_bot.destroy

    respond_to do |format|
      format.html { redirect_to character_bots_url }
      #format.json { head :no_content }
    end
  end
end
