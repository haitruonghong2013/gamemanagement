class Api::V1::ShopController < ApplicationController
  before_filter :authenticate_user!
  include UUIDTools
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

  def buy_items
    item_ids_array =[]
    params[:buy_item][:item_ids].each do |item_id|
      item_ids_array.push(UUIDTools::UUID.parse(item_id))
    end

    #UUIDTools::UUID.parse_hexdigest(params[:buy_item][:item_ids][0])
    items = Item.where('items.id in (?)',item_ids_array)

    if items and items.size != 0
      if params[:buy_item][:method] == 'gold'
        total_gold = Item.where('items.id in (?)',item_ids_array).sum(:gold)
        if current_user.character.gold >= total_gold

          UserItem.transaction do
            begin
              items.each do |item|
                user_item = UserItem.new
                user_item.name = item.name
                user_item.description = item.description
                user_item.user = current_user
                user_item.character = current_user.character
                user_item.atk = item.atk
                user_item.def = item.def
                user_item.health = item.health
                user_item.level = item.level
                user_item.dam = item.dam
                user_item.pc_dam = item.pc_dam
                user_item.pc_atk = item.pc_atk
                user_item.save
              end

              current_user.character.gold = current_user.character.gold - total_gold
              if current_user.character.save
                render :status => 200,
                       :json => {:success => true,
                                 :data => "Buy items success!"
                       }
              else
                render_json_error("422", current_user.character.errors)
              end

            rescue Exception => e
              raise ActiveRecord::Rollback
            end
          end
        else
          render_json_error("404", "User don't have enough gold to buy these items!")
        end
      elsif params[:buy_item][:method] == 'gem'
        render_json_error("422", "Action not complete!")
          #TODO:buy by gem
      else
        render_json_error("422", "Action not complete!")
      end

    else
      render_json_error("422", "you don't choose any item")
    end
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
        user_item.dam = item.dam
        user_item.pc_dam = item.pc_dam
        user_item.pc_atk = item.pc_atk

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
        user_item.dam = item.dam
        user_item.pc_dam = item.pc_dam
        user_item.pc_atk = item.pc_atk

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