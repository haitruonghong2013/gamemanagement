class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       if user.has_role? :admin
         #can :manage, :all
         can :manage, User
         can :manage, Character
         can :manage, Score
         can :manage, Item
         can :manage, ItemGroup
         can :manage, ItemType
         can :manage, CharacterBot
         can :manage, Race
         can :manage, Version
         can :manage, UserItem
         can :manage, SmsRequest

       #else
       #  can :read, :all
       end

       #if user.has_role? :businessOwner
       #  #can :show, Post
       #  #can :create, Post
       #  #can :index, Post
       #  can :manage, User,:organization_id => user.organization_id
       #
       #end
       #
       #if user.has_role? :saleLeader
       #  #can :show, Post
       #  #can :update, Post
       #  #can :index, Post
       #  #can :manage, Meeting do |meeting|
       #  #  !meeting.created_by.nil? and User.find(meeting.created_by).organization_id == user.organization_id
       #  #end
       #end
       #
       #if user.has_role? :saleStaff
       #  #can :index, Post
       #  can :show, Client
       #  can :get_my_client,Client
       #  can :search_my_clients,Client
       #  can [:index,:show,:start_meeting], Meeting
       #  can [:index,:show], Schedule
       #  can :create_note,Client
       #  can :get_notes_by_client,Client
       #  can :create_client_answer,Client
       #  can :update_client_answer,Client
       #  can :get_client_answers_by_client_and_question,Client
       #end


    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
