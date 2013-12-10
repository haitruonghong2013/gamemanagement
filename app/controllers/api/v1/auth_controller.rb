class Api::V1::AuthController  < ApplicationController
  include UserHelper
  def is_login
    user = User.find_all_by_authentication_token(params[:auth_token]).first
    if user and user.is_login == true
      render :json => { :success => true,
                 :online => true
      }
    else
      render :json => { :success => true,
                        :online => false
      }
    end
  end

   def auth_fb
     #TODO:check access_token
     found_users = User.where('facebook_id = ?',params[:auth][:facebook_id])
     if found_users.nil? or found_users.length == 0
       response = load_user_ubox

       case response.code
         when 200
           puts "All good!"
           body = JSON.parse(response.body)

           create_user = User.new
           #create_user.password = '12345678'
           #create_user.password_confirmation = '12345678'
           create_user.address  = body["address"]
           create_user.apn_token = body["apn_token"]
           create_user.area_code = body["area_code"]
           create_user.avatar = body["avatar"]
           create_user.birthday = body["birthday"]
           create_user.city = body["city"]
           create_user.country = body["country"]
           create_user.cover = body["cover"]
           create_user.created_date = body["created_date"]
           create_user.email = body["email"]
           create_user.facebook_id  = body["facebook_id"]
           create_user.gcm_token  = body["gcm_token"]
           create_user.google_id = body["google_id"]
           create_user.language = body["language"]
           create_user.name = body["name"]
           create_user.username = body["name"].delete(' ')
           create_user.first_name = first_name(body["name"])
           create_user.last_name =  last_name(body["name"])
           create_user.note  = body["note"]
           create_user.telephone  = body["phone"]
           create_user.sex   = body["sex"]
           create_user.twitter_id  = body["twitter_id"]
           create_user.user_type   = body["type"]
           create_user.avatar_thumb = body["avatar_thumb"]
           create_user.ubox_authentication_token = body["authentication_token"]
           create_user.add_role :normalUser
           if create_user.save(:validate => false)

             render :status => 200,
                    :json => { :success => true,
                               :data => create_user.as_json
                    }
           else
             render :status => 409,
                    :json => {
                        :success => false,
                        :info => 'Create user fails!',
                        :data => @contract.errors
                    }
           end


         when 404
           puts "not found!"
           render :status => 404,
                  :json => { :success => false,
                             :data => {}
                  }
         when 500...600
           puts "ERROR #{response.code}"
           render :status => response.code,
                  :json => { :success => false,
                             :data => {}
                  }
       end
     else
       render :status => 200,
              :json => { :success => true,
                         :data => found_users.first.as_json
              }
     end

#     url = 'http://ws.uboxapp.com/oauth/facebook_normal.json/'
#     uri = URI.parse('http://ws.uboxapp.com/oauth/facebook_normal.json/')
#     require 'net/http'
     #require 'net/http'
     #request = Net::HTTP::Post.new(url)
     ##request.add_field "Content-Type", "application/x-www-form-urlencoded"
     #request.set_content_type('application/x-www-form-urlencoded')
     #request.set_form(JSON.dump(@payload))
     #
     #
     #uri = URI.parse(url)
     #http = Net::HTTP.new(uri.host, uri.port)
     #response = http.request(request)




   end

  private
  def load_user_ubox
    @payload = params[:auth]
    #@payload = {
    #    "token"=> "CAAGZAvfspq08BANhzngSa2ZBPBwAq4MIZACYd47EZC74zXpQjATnNdZBbgoUdnMgkal52wke55pZBeRNZAwWTq55NcY9Gv8ZAbBb2L9wnrrnBXwLB17ScI7KBngkGFLd4QLlFcEBwr9oVj0iVf9xaGGFqRHYqpeaMQbeSALltWb7gTrXAbApPAtV",
    #    "facebook_id"=> "100000198194432",
    #    "name"=> "Anh Tung Hoang",
    #    "email"=> "tungbeng2006@gmail.com",
    #    "birthday"=> "06/20/1990",
    #    "sex"=> "male",
    #    "address"=> "Hanoi, Vietnam"
    #}
    response = HTTParty.post('http://ws.uboxapp.com/oauth/facebook_normal.json/', :body =>JSON.dump(@payload), :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'} )
    return response
  end

end