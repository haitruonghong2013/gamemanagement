class CharactersController < ApplicationController
  # GET /characters
  # GET /characters.json
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction
  def index
    @characters = Character.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => params[:size]? params[:size]:PAGE_SIZE )
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @characters }
      format.js
    end
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @character = Character.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @character }
    end
  end

  # GET /characters/new
  # GET /characters/new.json
  def new
    @character = Character.new
    #@races = Race.all
    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @character }
    end
  end

  # GET /characters/1/edit
  def edit
    @character = Character.find(params[:id])
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(params[:character])
    user = User.find(params[:character][:user_id])
    if user and user.character
      #render_json_error("409","user already have a character.")
      respond_to do |format|
        format.html {
          flash[:error] = 'User had a characters. Please choose another user!'
          render action: "new"
        }
      end

      #render :html=>{action: "new"}
    else
      @character.user = user
      #Use  Character default attributes
      #@character.medal = Character::DEFAULT_ATTRS_VALUES[:medal]
      #@character.lv = Character::DEFAULT_ATTRS_VALUES[:lv]
      #@character.gold = Character::DEFAULT_ATTRS_VALUES[:gold]
      #@character.lose_number = Character::DEFAULT_ATTRS_VALUES[:lose_number]
      #@character.win_number = Character::DEFAULT_ATTRS_VALUES[:win_number]
      #@character.ban = Character::DEFAULT_ATTRS_VALUES[:ban]
      #@character.life = Character::DEFAULT_ATTRS_VALUES[:life]

      #if params[:character][:char_race]
      #  select_race = Race.find_all_by_char_race(params[:character][:char_race]).first
      #  if select_race
      #    @character.atk1 = select_race.atk1
      #    @character.atk2 = select_race.atk2
      #    @character.atk3 = select_race.atk3
      #    @character.def = select_race.def
      #    @character.hp =  select_race.hp
      #    @character.mp =  select_race.mp
      #  else
      #    #Use  Race default attributes
      #    @character.atk1 = Race::DEFAULT_ATTRS_VALUES[:atk1]
      #    @character.atk2 = Race::DEFAULT_ATTRS_VALUES[:atk2]
      #    @character.atk3 = Race::DEFAULT_ATTRS_VALUES[:atk3]
      #    @character.def = Race::DEFAULT_ATTRS_VALUES[:def]
      #    @character.hp =  Race::DEFAULT_ATTRS_VALUES[:hp]
      #    @character.mp =  Race::DEFAULT_ATTRS_VALUES[:mp]
      #  end
      #end

      respond_to do |format|
        if @character.save
          format.html { redirect_to @character, notice: 'Character was successfully created.' }
          #format.json { render json: @character, status: :created, location: @character }
        else
          format.html { render action: "new" }
          #format.json { render json: @character.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /characters/1
  # PUT /characters/1.json
  def update
    @character = Character.find(params[:id])

    respond_to do |format|
      if @character.update_attributes(params[:character])
        format.html { redirect_to @character, notice: 'Character was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character = Character.find(params[:id])
    @character.destroy

    respond_to do |format|
      format.html { redirect_to characters_url }
      #format.json { head :no_content }
    end
  end

  def sort_column
    Character.column_names.include?(params[:sort]) ? params[:sort] : "char_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
