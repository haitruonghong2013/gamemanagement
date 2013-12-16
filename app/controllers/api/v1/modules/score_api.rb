module ScoreAPI

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

end