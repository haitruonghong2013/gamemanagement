load "api/v1/modules/user_api.rb"
load "api/v1/modules/score_api.rb"
load "api/v1/modules/character_api.rb"
class Api::V1::GameController  < ApplicationController
  before_filter :authenticate_user!, :except => [:check_version]
  include UUIDTools

#--------------------------------User API -------------------
  include UserAPI
#--------------------------------Score API -------------------
  include ScoreAPI
#--------------------------------Character API -------------------
  include CharacterAPI
#--------------------------------Cache actions -------------------
  caches_action :list_all_user
  caches_action :get_top_score_by_time
  cache_sweeper :fragment_sweeper
  #caches_action :get_character,:cache_path => Proc.new { |c| c.params }
end