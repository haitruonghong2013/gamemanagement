class FragmentSweeper < ActionController::Caching::Sweeper
  observe Score

  include Rails.application.routes.url_helpers

  def after_create(record)
    expire_cache_for(record)
  end

  def after_save(record)
    expire_cache_for(record)
  end

  def after_update(record)
    expire_cache_for(record)
  end

  def after_destroy(record)
    expire_cache_for_delete(record)
  end

  private
  def expire_cache_for_delete(record)
    @controller ||= ActionController::Base.new
    #if record.is_a?(Score)
    expire_action(:controller => '/scores', :action => 'index')
    Rails.logger.debug "***\n>>> scores action index cache fragment expired!\n***" if Rails.env.development?
    #expire_action(:controller => '/scores', :action => 'show')
    #Rails.logger.debug "***\n>>> scores action show cache fragment expired!\n***" if Rails.env.development?
    #end

  end

  def expire_cache_for(record)
    @controller ||= ActionController::Base.new
    ##expire_fragment "users/#{record.id}-#{record.updated_at.to_i}"
    ##expire_fragment "users/#{record.id}"
    #expire_action(:controller => '/users', :action => 'index')
    #expire_action(:controller => '/users', :action => 'show')
    #expire_action(:controller => '/api/v1/game', :action => 'list_all_user',:format=>:json)
    #if record.is_a?(User)
    #
    #end
    #
    #if record.is_a?(Score)
    expire_action(:controller => '/scores', :action => 'index')

    #check condition for reset cache
    cache_key = "views/#{request.host_with_port}/api/v1/game/get_top_score_by_time.json*"
    if record.score
      $redis.keys(cache_key).each do |key|
        after_time = key.partition('=').last
        if !after_time.blank?
          sql = "SELECT COUNT(*) from (SELECT characters.char_name, characters.lv, scores.character_id, max(score) FROM scores INNER JOIN characters on characters.id = scores.character_id WHERE (scores.score > #{record.score} and scores.created_at >= '#{after_time}') Group by character_id ORDER BY max(score)) as table_A"
          logger.debug "execute sql  #{sql}"
          rank_score =  ActiveRecord::Base.connection.execute(sql)
          if rank_score.first[0] < 10

            logger.debug "expire_cache_for #{cache_key}"
            #Rails.cache.delete(cache_key)
            Rails.cache.delete_matched(cache_key)
            break
          end
        end
      end
    end
    #end
    #Rails.logger.debug "***\n>>> users #{record.id} cache fragment expired!\n***" if Rails.env.development?
  end

  #def expire_top_score_cache
  #  if record.is_a?(Score)
  #    cache_key = "views/#{request.host_with_port}/api/v1/game/get_top_score_by_time.json"
  #    Rails.cache.delete(cache_key)
  #  end
  #end
  #
  #def expire_list_all_user_cache
  #  cache_key = "views/#{request.host_with_port}/api/v1/game/list_abc_user.json"
  #  Rails.cache.delete(cache_key)
  #end

  def funky_action_cache_name(route, params)
    Rails.application.routes.url_helpers.send(route.to_s+'_url', params).gsub(/https?:\/\//,'')
  end
end