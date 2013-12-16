module UserAPI

  def list_all_user

    all_users = User.joins(:roles).where('roles.name != ?',:admin)
    respond_to do |format|
      format.json { render json: all_users }
    end
  end

  def list_user_random
    #expire_list_all_user_cache
    expire_action(:controller => '/api/v1/game', :action => 'list_all_user',:format=>:json)
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
end