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
    top__char_scores = []
    #top_scores = Score.where('scores.created_at >=  ?', params[:after_time]).group(:character_id).order('score DESC').limit(10).includes(:character)
    #Score.find_by_sql()
    created_at = params[:after_time]
    sql = "SELECT characters.char_name, characters.lv, scores.character_id, max(score) FROM scores INNER JOIN characters on characters.id = scores.character_id WHERE (scores.created_at >= '#{created_at}') Group by character_id ORDER BY max(score) DESC LIMIT 10"
    #st = ActiveRecord::Base.connection.raw_connection.prepa(sql)
    #
    #records_array = st.execute(params[:after_time])
    records_array =  ActiveRecord::Base.connection.execute(sql)

    records_array.each do |record|
      top__char_scores.push({
                                :score => record[3],
                                :char_name => record[0],
                                :character_id => UUIDTools::UUID.parse_raw(record[2]),
                                :level => record[1]
                            })
    end
    #records_array.map! {
    #    |top_score|
    #  {
    #      :score => top_score.score,
    #      :char_name => (top_score.character ? top_score.character.char_name : ''),
    #      :character_id => (top_score.character ? top_score.character.id : ''),
    #      :level => (top_score.character ? top_score.character.lv : ''),
    #  }
    #}

    render :status => 200,
           :json => { :success => true,
                      :top_scores => top__char_scores
           }
  end


  def get_top_gold_by_time
    top_golds = Character.where('updated_at >=  ?', params[:after_time]).order(:gold).reverse_order.limit(10)

    top_golds.map! {
        |top_gold|
      {
          :gold => top_gold.gold,
          :char_name => top_gold.char_name,
          :character_id => top_gold.id,
          :level => top_gold.lv
      }
    }

    render :status => 200,
           :json => { :success => true,
                      :top_golds => top_golds
           }
  end


  def get_top_level_by_time
    top_levels = Character.where('updated_at >=  ?', params[:after_time]).order(:lv).reverse_order.limit(10)

    top_levels.map! {
        |top_level|
      {
          :char_name => top_level.char_name,
          :character_id => top_level.id,
          :level => top_level.lv
      }
    }

    render :status => 200,
           :json => { :success => true,
                      :top_levels => top_levels
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
        #rank_score = max_score.ranking(params[:after_time])
        created_at = params[:after_time]
        sql = "SELECT COUNT(*) from (SELECT characters.char_name, characters.lv, scores.character_id, max(score) FROM scores INNER JOIN characters on characters.id = scores.character_id WHERE (scores.score > #{max_score.score} and scores.created_at >= '#{created_at}') Group by character_id ORDER BY max(score)) as table_A"
        rank_score =  ActiveRecord::Base.connection.execute(sql)
        render :status => 200,
               :json => { :success => true,
                          :rank_score => rank_score.first[0]+1
               }
      else
        render_json_error("404","User don't have a score!")
      end
    else
      render_json_error("404","User don't have this character!")
    end
  end

  def get_my_gold_rank_by_time
    if current_user.character
      rank_gold = current_user.character.gold_ranking(params[:after_time])
      render :status => 200,
             :json => { :success => true,
                        :rank_gold => rank_gold+1,
                        :gold => current_user.character.gold
             }
    else
      render_json_error("404","User don't have this character!")
    end
  end

  def get_my_level_rank_by_time
    if current_user.character
      rank_level = current_user.character.level_ranking(params[:after_time])
      render :status => 200,
             :json => { :success => true,
                        :rank_level => rank_level+1,
                        :level => current_user.character.lv
             }
    else
      render_json_error("404","User don't have this character!")
    end
  end

end