module CharacterAPI
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
      #character.medal = Character::DEFAULT_ATTRS_VALUES[:medal]
      #character.lv = Character::DEFAULT_ATTRS_VALUES[:lv]
      #character.gold = Character::DEFAULT_ATTRS_VALUES[:gold]
      #character.lose_number = Character::DEFAULT_ATTRS_VALUES[:lose_number]
      #character.win_number = Character::DEFAULT_ATTRS_VALUES[:win_number]
      #character.ban = Character::DEFAULT_ATTRS_VALUES[:ban]
      #character.life = Character::DEFAULT_ATTRS_VALUES[:life]

      #if params[:character][:char_race]
      #  select_race = Race.find_all_by_char_race(params[:character][:char_race]).first
      #  if select_race
      #    character.atk1 = select_race.atk1
      #    character.atk2 = select_race.atk2
      #    character.atk3 = select_race.atk3
      #    character.def = select_race.def
      #    character.hp =  select_race.hp
      #    character.mp =  select_race.mp
      #  else
      #    #Use  Race default attributes
      #    character.atk1 = Race::DEFAULT_ATTRS_VALUES[:atk1]
      #    character.atk2 = Race::DEFAULT_ATTRS_VALUES[:atk2]
      #    character.atk3 = Race::DEFAULT_ATTRS_VALUES[:atk3]
      #    character.def = Race::DEFAULT_ATTRS_VALUES[:def]
      #    character.hp =  Race::DEFAULT_ATTRS_VALUES[:hp]
      #    character.mp =  Race::DEFAULT_ATTRS_VALUES[:mp]
      #  end
      #end

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

  def check_version
    max_version = Version.maximum(:version)
    if params[:check_version][:current_version] and max_version <= params[:check_version][:current_version]
      render :status => 200,
             :json => { :success => true,
                        :valid => true,
                        :download_url =>''
             }
    else
      latest_version = Version.where("version = ?",max_version).first
      render :status => 200,
             :json => { :success => true,
                        :valid => false,
                        :download_url => latest_version.download_url
             }
    end
  end

end