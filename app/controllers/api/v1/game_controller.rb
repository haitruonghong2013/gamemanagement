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
    if current_user.character
      random_characters = Character.where('lv <= ? and lv >= ?',current_user.character.lv + 5, current_user.character.lv - 5).limit(10).order("RAND()")
      render :status => 200,
             :json => { :success => true,
                        :data => random_characters.as_json
             }
    else
      render_json_error("404","User don't have a character!")
    end
  end

  def set_win_lose_game

  end
  #--------------------------------Score API -------------------

  def submit_score
    score = Score.new(params[:score])
    character = Character.find_all_by_char_name(params[:score][:char_name]).first
    if character and current_user.character and current_user.character.id == character.id
    #score.character_id = current_user.character.id
    #if true
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
     top_scores = Score.where('created_at >=  ?', params[:after_time]).order(:score).reverse_order.limit(10)

     top_scores.map! {
         |top_score|
       {
           :score => top_score.score,:char_name => (top_score.character ? top_score.character.char_name : '')
       }
     }

     render :status => 200,
            :json => { :success => true,
                       :top_scores => top_scores
            }
  end

  #highest score
  def get_my_score
    #character = current_user.character
    if current_user.character.char_name == params[:char_name]
      score = Score.where('character_id = ?',character.id).maximum('score')
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
    if current_user.character and current_user.character.char_name == params[:char_name]
      max_score = Score.maximum_score(current_user.character.id, params[:after_time])
      rank_score = max_score.ranking(params[:after_time])
      render :status => 200,
             :json => { :success => true,
                        :rank_score => rank_score+1
             }
    else
      render_json_error("404","User don't have this character!")
    end
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