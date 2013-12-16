load "api/v1/modules/user_api.rb"
load "api/v1/modules/score_api.rb"
load "api/v1/modules/character_api.rb"
class Api::V1::GameController  < ApplicationController
  before_filter :authenticate_user!

  #caches_action :list_all_user

  #def expire_list_all_user_cache
  #  cache_key = "views/#{request.host_with_port}/api/v1/game/list_all_user.json"
  #  Rails.cache.delete(cache_key)
  #end
#--------------------------------User API -------------------
  include UserAPI
  #--------------------------------Score API -------------------
  include ScoreAPI
  #--------------------------------Character API -------------------
  include CharacterAPI
end