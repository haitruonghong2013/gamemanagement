#load "api/v1/modules/user_api.rb"
#load "api/v1/modules/score_api.rb"
#load "api/v1/modules/character_api.rb"
class Api::V1::GameController  < ApplicationController
  before_filter :authenticate_user!
  #caches_action :list_all_user
  #caches_action :get_character,:cache_path => Proc.new { |c| c.params }

  #def expire_list_all_user_cache
  #  cache_key = "views/#{request.host_with_port}/api/v1/game/list_all_user.json"
  #  Rails.cache.delete(cache_key)
  #end
#--------------------------------User API -------------------
#  include UserAPI
  def list_all_user
    all_users = User.joins(:roles).where('roles.name != ?',:admin)
    respond_to do |format|
      format.json { render json: all_users }
    end
  end

  def list_user_random
    #expire_list_all_user_cache
    #expire_action(:controller => '/api/v1/game', :action => 'list_all_user',:format=>:json)
    if current_user.character
      random_characters = Character.joins(:user).where('lv <= ? and lv >= ? and is_login = ?',current_user.character.lv + 5, current_user.character.lv - 5, true).limit(10).order("RAND()")
      if random_characters.nil? or random_characters.size == 0
        #random_characters = CharacterBot.where('lv <= ? and lv >= ?',current_user.character.lv + 5, current_user.character.lv - 5).limit(10).order("RAND()")
        #with mysql: RAND()
        #with postgre: RANDOM()
        random_characters = CharacterBot.order("RAND()").limit(10)
      end
      render :status => 200,
             :json => { :success => true,
                        :data => random_characters.as_json
             }
    else
      render_json_error("404","User don't have a character!")
    end
  end


  def list_random_character_bots
      random_character_bots = CharacterBot.order("RAND()").limit(10)
      render :status => 200,
             :json => { :success => true,
                        :data => random_character_bots.as_json
             }
  end

  def set_win_lose_game
    character = current_user.character
    lose_number = params[:character][:lose_number] ? params[:character][:lose_number] : '0'
    win_number = params[:character][:win_number] ? params[:character][:win_number] : '0'

    if character
      character.lose_number += lose_number.to_i
      character.win_number += win_number.to_i
      if character.save
        render :status => 200,
               :json => { :success => true,
                          :data => "Set win lose success!"
               }
      else
        render_json_error("422",character.errors)
      end
      #if params[:score][:score]
      #  new_score = Score.new
      #  new_score.score = params[:score][:score]
      #  new_score.character = current_user.character
      #  if new_score.save
      #    render :status => 200,
      #           :json => { :success => true,
      #                      :data => "Create success!"
      #           }
      #  else
      #    render_json_error("422",new_score.errors)
      #  end
      #else
      #  render_json_error("400","Bad request!")
      #end
    else
      render_json_error("404","User don't have a character!")
    end
  end
  #--------------------------------Score API -------------------
  #include ScoreAPI
  def submit_score
    score = Score.new(params[:score])
    #character = currrent_user.character
    begin
      character = Character.find(params[:score][:character_id])
      #if character and current_user.character and current_user.character.id == character.id
      #score.character_id = current_user.character.id
      #if true
      if character and current_user.character.id == character.id
        if score.save
          #format.json { render json: score, status: :created, location: score }
          render :status => 201,
                 :json => { :success => true,
                            :score => score.as_json
                 }
        else
          format.json { render json: score.errors, status: :unprocessable_entity }
        end
      else
        render_json_error("404","User don't have this character!")
      end
    rescue ActiveRecord::RecordNotFound => e
      #render_json_error 417,e.message
      render_json_error("404","User don't have this character!")
    end
  end

  def get_top_score_by_time
    top_scores = Score.where('scores.created_at >=  ?', params[:after_time]).order(:score).reverse_order.limit(10).includes(:character)

    top_scores.map! {
        |top_score|
      {
          :score => top_score.score,
          :char_name => (top_score.character ? top_score.character.char_name : ''),
          :level => (top_score.character ? top_score.character.lv : ''),
      }
    }

    render :status => 200,
           :json => { :success => true,
                      :top_scores => top_scores
           }
  end

  #highest score
  def get_my_score
    character = current_user.character
    if character
      #and current_user.character.char_name == params[:char_name]
      score = Score.where('character_id = ?',character.id).maximum('score')
      if score.nil?
        score = 0
      end
      render :status => 200,
             :json => { :success => true,
                        :score => score
             }
    else
      render_json_error("404","User don't have this character!")
    end
    #if character
    #  score = Score.where('character_id = ?',character.id).maximum('score')
    #  render :status => 200,
    #         :json => { :success => true,
    #                    :score => score
    #         }
    #else
    #  render_json_error("404","User don't have this character!")
    #end
  end

  def get_my_rank_by_time
    #if current_user.character and current_user.character.char_name == params[:char_name]
    if current_user.character
      max_score = Score.maximum_score(current_user.character.id, params[:after_time])
      if max_score
        rank_score = max_score.ranking(params[:after_time])
        render :status => 200,
               :json => { :success => true,
                          :rank_score => rank_score+1
               }
      else
        render_json_error("404","User don't have a score!")
      end
    else
      render_json_error("404","User don't have this character!")
    end
  end
  #--------------------------------Character API -------------------
  #include CharacterAPI
  def check_charname
    exist_character = Character.find_all_by_char_name(params[:char_name]).first
    if exist_character
      render :status => 200,
             :json => { :success => true,
                        :existing => true
             }
    else
      render :status => 200,
             :json => { :success => true,
                        :existing => false
             }
    end
  end

  def update_character
    character = current_user.character
    if character
      if character.update_attributes(params[:character])
        render :status => 200,
               :json => { :success => true,
                          :data => 'update success!',
                          :character=>{
                              :update_at => character.updated_at.to_time.to_i
                          }

               }
      else
        render_json_error("422",character.errors)
      end
    else
      render_json_error("404","User don't have a character!")
    end

  end

  def new_character
    character = Character.new(params[:character])

    if current_user.character
      render_json_error("409","user already have a character.")
    else
      character.user = current_user

      #Use  Character default attributes
      character.medal = Character::DEFAULT_ATTRS_VALUES[:medal]
      character.lv = Character::DEFAULT_ATTRS_VALUES[:lv]
      character.gold = Character::DEFAULT_ATTRS_VALUES[:gold]
      character.lose_number = Character::DEFAULT_ATTRS_VALUES[:lose_number]
      character.win_number = Character::DEFAULT_ATTRS_VALUES[:win_number]
      character.ban = Character::DEFAULT_ATTRS_VALUES[:ban]
      character.life = Character::DEFAULT_ATTRS_VALUES[:life]

      if params[:character][:char_race]
        select_race = Race.find_all_by_char_race(params[:character][:char_race]).first
        if select_race
          character.atk1 = select_race.atk1
          character.atk2 = select_race.atk2
          character.atk3 = select_race.atk3
          character.def = select_race.def
          character.hp =  select_race.hp
          character.mp =  select_race.mp
        else
          #Use  Race default attributes
          character.atk1 = Race::DEFAULT_ATTRS_VALUES[:atk1]
          character.atk2 = Race::DEFAULT_ATTRS_VALUES[:atk2]
          character.atk3 = Race::DEFAULT_ATTRS_VALUES[:atk3]
          character.def = Race::DEFAULT_ATTRS_VALUES[:def]
          character.hp =  Race::DEFAULT_ATTRS_VALUES[:hp]
          character.mp =  Race::DEFAULT_ATTRS_VALUES[:mp]
        end
      end

      if character.save
        render :status => 200,
               :json => { :success => true,
                          :character => character.as_json
               }
        #respond_to do |format|
        # format.json { render json: character, status: :created, location: character }
        #end
      else
        #puts character.errors.messages
        render_json_error("422",character.errors)
        #format.json { render json: character.errors, status: :unprocessable_entity }
      end

    end
  end

  def delete_character
    #character = Character.find(params[:id])
    character = current_user.character
    if character
      character.destroy
      render :status => 200,
             :json => { :success => true,
                        :data => 'delete success!'
             }
    else
      render_json_error("404","User don't have a character!")
    end
    #respond_to do |format|
    #  format.json { head :no_content }
    #end
  end

  def get_character
    character = current_user.character
    if character
      render :status => 200,
             :json => { :success => true,
                        :character => character.as_json
             }
    else
      render_json_error("404","User don't have a character!")
    end
  end

  #use for update character if user play offline
  def check_character_change
    character = current_user.character
    if character
      if params[:character]
        is_change = character.atk1 != params[:character][:atk1].to_i or
            character.atk2 != params[:character][:atk2].to_i or
            character.atk3 != params[:character][:atk3].to_i or
            character.def != params[:character][:def].to_i or
            character.gold != params[:character][:gold].to_i or
            character.hp != params[:character][:hp].to_i or
            character.lv != params[:character][:lv].to_i or
            character.medal != params[:character][:medal].to_i or
            character.lose_number != params[:character][:lose_number].to_i or
            character.win_number != params[:character][:win_number].to_i
        render :status => 200,
               :json => { :success => true,
                          :change => is_change
               }

      else
        render :status => 200,
               :json => { :success => true,
                          :change => false
               }
      end
    else
      render_json_error("404","User don't have a character!")
    end
  end
end