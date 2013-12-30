GameManagement::Application.routes.draw do
  #Rails.application.routes.default_url_options[:host] = 'sdfsdf:3000'
  resources :item_types


  resources :user_items
  resources :items
  resources :item_groups
  resources :character_bots
  resources :races

  resources :static_page_configures do
    collection do

      get :introduction_show
      get :introduction_edit,:as=>'introduction_edit'
      post :introduction_update,:as=>'introduction_update'

      get :about_us_show
      get :about_us_edit,:as=>'about_us_edit'
      post :about_us_update,:as=>'about_us_update'

      get :package_payment_show
      get :package_payment_edit,:as=>'package_payment_edit'
      post :package_payment_update,:as=>'package_payment_update'

    end
  end
  match '/game_play'=> 'posts#list_game_play'
  match '/introduction'=> 'static_page_configures#introduction_show'
  match '/about_us'=> 'static_page_configures#about_us_show'
  match '/package_payment'=> 'static_page_configures#package_payment_show'
  #match '/api/v1/registration'=> 'registrations#register'
  #
  #
  #resources :client_notes
  #
  #resources :meeting_duration_times do
  #  collection do
  #    post 'add_tracking_meeting'=>'meeting_duration_times#create'
  #  end
  #end
  #
  #
  #
  #resources :travel_times do
  #  collection do
  #    post 'add_time_traveling'=>'travel_times#create'
  #  end
  #end
  #
  #
  #resources :staff_tracking_positions do
  #  collection do
  #    post 'track_staff_position'=>'staff_tracking_positions#create'
  #  end
  #end
  #
  #
  #resources :major_variance_logs do
  #  collection do
  #    post 'add_track_late'=>'major_variance_logs#create'
  #  end
  #end
  #
  #
  #resources :client_answers
  #
  #
  #resources :user_questions
  #
  #
  #resources :questions
  #
  #
  #resources :industries
  #
  #
  #resources :push_notifications do
  #  collection do
  #    post :register_device
  #    #post :update_notif
  #    post :remove_device
  #  end
  #end


  #resources :locations
  #
  #
  #resources :schedules do
  #  collection do
  #    get '/view_assign_staff/:id' =>:view_assign_staff,:as=>'view_assign_staff'
  #    post :do_assign_staff,:as=>'do_assign_staff'
  #  end
  #end
  #
  #
  #resources :meetings do
  #  collection do
  #    get 'my_meetings'=> :get_my_meetings
  #    get 'meetings_by_staff' => :get_meetings_by_staff
  #    get :start_meeting
  #  end
  #end


  #resources :clients do
  #  collection do
  #    post 'new_client'=>'clients#create'
  #    get 'my_client'=>'clients#get_my_client'
  #    get 'clients_by_staff' => :get_all_clients_by_user
  #    get 'search_clients' => :search_all_clients
  #    get 'search_myclients' => :search_my_clients
  #    get 'search_clients_by_staff' =>:search_clients_by_staff
  #    post :create_note
  #    post :update_client_answer
  #    post :create_client_answer
  #    get :get_notes_by_client
  #    get 'get_client_answers' =>:get_client_answers_by_client_and_question
  #    get '/client_validation/:id' =>:client_validation, :as=>'client_validation'
  #    post '/do_validate_client/:id' =>:do_validate_client, :as=>'do_validate_client'
  #  end
  #end


  resources :posts do
    collection do
      delete :destroy_multiple
    end
  end


  #get "home/index"

  devise_for :user,:path_prefix => 'd',:controllers => { :registrations => "registrations" }
  #devise_for :users,:path_prefix => 'd', :skip => [:registrations]
  #as :user do
  #  get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
  #  put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'
  #end
  #resource :users
  devise_scope :user do
    post 'login' => 'sessions#create', :as => 'login'
    delete 'logout' => 'sessions#destroy', :as => 'logout'
    post '/api/v1/login' => 'sessions#create', :as => 'login'
    post '/api/v1/login_by_device' => 'sessions#login_by_device_id', :as => 'login_by_device'

    delete '/api/v1/logout' => 'sessions#destroy', :as => 'logout'
    post '/api/v1/registration' => 'registrations#register', :as => 'api_registration', :defaults => {:format => 'json'}
  end

  resources :users
  resources :scores
  resources :characters


  root :to => "home#index"

  namespace :api do
    namespace :v1  do
      resources :game do
        collection do
          get :list_all_user
          get :list_user_random
          get :list_user_around_level
          post :set_win_lose_game
          post :submit_score
          get :get_top_score_by_time
          get :get_top_gold_by_time
          get :get_top_level_by_time
          get :get_my_score
          get :get_my_rank_by_time
          get :get_my_gold_rank_by_time
          get :get_my_level_rank_by_time
          get :check_charname
          post :update_character
          post :new_character
          delete :delete_character
          get :get_character
          post :check_character_change
          get :list_random_character_bots
        end
      end

      resources :auth do
        collection do
          post :auth_fb
          get :is_login
        end
      end

      resources :shop do
        collection do
          get :list_items_by_group
          post :buy_item
          post :buy_items
          get :list_user_item
        end
      end
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
