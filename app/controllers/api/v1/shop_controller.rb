class Api::V1::ShopController < ApplicationController
  before_filter :authenticate_user!
#--------------------------------Item API -------------------
  def list_user_item_by_group
    #items = Item.joins(:item_groups).where('item_groups.name = ?', params[:group_name])
    #render :status => 200,
    #       :json => {:success => true,
    #                 :data => items.as_json
    #       }
  end

  def list_items_by_group
    items = Item.joins(:item_group).where('item_groups.name = ?', params[:group_name])
    render :status => 200,
           :json => {:success => true,
                     :data => items.as_json
           }
  end

  def buy_item
    item = Item.find(params[:buy_item][:item_id])
    if params[:buy_item][:method] == 'gold'
      if current_user.character.gold >= item.gold
        user_item = UserItem.new

        user_item.name = item.name
        user_item.description = item.description
        user_item.user = current_user
        user_item.character = current_user.character
        user_item.atk = item.atk
        user_item.def = item.def
        user_item.health = item.health
        user_item.level = item.level

        UserItem.transaction do
          begin
            if user_item.save
              current_user.character.gold = current_user.character.gold - item.gold
              current_user.character.save
              render :status => 200,
                     :json => {:success => true,
                               :data => "Buy item success!"
                     }
            else
              render_json_error("422", user_item.errors)
            end
          rescue Exception => e
            raise ActiveRecord::Rollback
          end
        end
      else
        render_json_error("404", "User don't have enough gold to buy this item!")
      end
    elsif params[:buy_item][:method] == 'gem'
      if current_user.character.gem >= item.gem
        user_item = UserItem.new
        user_item.name = item.name
        user_item.description = item.description
        user_item.user = current_user
        user_item.character = current_user.character
        user_item.atk = item.atk
        user_item.def = item.def
        user_item.health = item.health
        user_item.level = item.level

        UserItem.transaction do
          begin
            if user_item.save
              current_user.gold = current_user.gem - item.gem
              current_user.save
              render :status => 200,
                     :json => {:success => true,
                               :data => "Buy item success!"
                     }
            else
              render_json_error("422", user_item.errors)
            end
          rescue Exception => e
            raise ActiveRecord::Rollback
            #render_json_error("404", "System error: "+e.messages)
          end
        end
      else
        render_json_error("404", "User don't have enough gem to buy this item!")
      end
    else
      render_json_error("422", "Action not complete!")
    end
  end
end