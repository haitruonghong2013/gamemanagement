class Api::V1::GameController  < ApplicationController
  before_filter :authenticate_user!
#--------------------------------User API -------------------
  def list_all_user
      all_users = User.joins(:roles).where('roles.name != ?',:admin)
      respond_to do |format|
        format.json { render json: all_users }
      end
  end

  def list_user_random
     #random_users = User.where
    if current_user.character
      character_lv = current_user.character.lv
      random_characters = Character.where('lv <= ? and lv >= ?',character_lv + 5, character_lv - 5).limit(10).order("RAND()")
      render :status => 200,
             :json => { :success => true,
                        :data => random_characters.as_json
             }
    else
      render_json_error("404","User don't have a character!")
    end

  end

  def list_user_around_level

  end

  def set_win_lose_game

  end
  #--------------------------------Score API -------------------

  def submit_score
    score = Score.new(params[:score])
    character = Character.find(params[:score][:character_id])
    if character and current_user.character.id == character.id
      respond_to do |format|
        if score.save
          format.json { render json: score, status: :created, location: score }
        else
          format.json { render json: score.errors, status: :unprocessable_entity }
        end
      end
    else
      render_json_error("404","User don't have this character!")
    end

  end

  def get_top_score_by_time

  end

  #highest score
  def get_my_score
    character = current_user.character
    if character
      score = Score.where('character_id = ?',character.id).maximum('score')
      render :status => 200,
             :json => { :success => true,
                        :score => score
             }
    else
      render_json_error("404","User don't have this character!")
    end
  end

  def get_my_rank_by_time

  end

  #--------------------------------Character API -------------------

  def update_character
    character = current_user.character
    if character
      respond_to do |format|
        if character.update_attributes(params[:character])
          format.json { head :no_content }
        else
          format.json { render json: character.errors, status: :unprocessable_entity }
        end
      end
    else
      render_json_error("404","User don't have a character!")
    end

  end

  def new_character
       character = Character.new(params[:character])
       respond_to do |format|
         if character.save
           format.json { render json: character, status: :created, location: character }
         else
           format.json { render json: character.errors, status: :unprocessable_entity }
         end
       end
  end

  def delete_character
    #character = Character.find(params[:id])
    character = current_user.character
    if character
      character.destroy
      render :json =>{}
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
      respond_to do |format|
        format.json { render json: character }
      end
    else
      render_json_error("404","User don't have a character!")
    end
  end

end