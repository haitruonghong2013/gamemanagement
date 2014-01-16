class Api::V1::ShopController < ApplicationController

  before_filter :authenticate_user!,:except => [:sms_charging]
  include UUIDTools
  CHARACTER_ID = 'CHARACTER_ID'
  def sms_charging
    #access_key	Đại diện cho sản phẩm của merchant khai báo trong hệ thống 1pay.vn
    #command 	Mã tin nhắn, là keyword đầu tiên trong tin nhắn của khách hàng , ví dụ tin nhắn có nội dung “DK Game” gửi 8038 thì command sẽ là DK
    #mo_message 	Nội dung tin nhắn của khách hàng
    #msisdn 	Số điện thoại của khách hàng, bắt đầu bằng 84, ví dụ 8498238193
    #request_id 	Id của tin nhắn, ở dạng String
    #request_time 	Thời gian đầu số nhận được tin nhắn, ở dạng iso, ví dụ: 2013-07-06T22:54:50Z
    #short_code 	Đầu số nhận tin nhắn, ví dụ tin nhắn có nội dung “DK Game” gửi 8038 thì short_code sẽ là 8038
    #signature 	Chữ ký, merchant có thể sử dụng signature để kiểm soát an ninh . Signature là một chuỗi string access_key=$access_key&command=$command&mo_message=$mo_message&msisdn=$msisdn&request_id=$request_id&request_time=$request_time&short_code=$short_code”được hmac bằng thuật toán SHA256 tham khảo tại Basic Authentication]
    #access_key=4353465&command=test&mo_message=MUC LOP LIFE CHARACTER_ID[546547567567]
    if params[:request_id].blank?
      render :status => 200,
             :json => {
                 :status => 0,
                 :sms => "Ban da mua that bai",
                 :type =>"confirm"
             }
      return
    else
      exist_sms_request = SmsRequest.where('request_id = ?',params[:request_id]).first
      if exist_sms_request
        render :status => 200,
               :json => {
                   :status => 0,
                   :sms => "Ban da mua that bai",
                   :type =>"confirm"
               }
        return
      end
    end



    mo_message = params[:mo_message]

    if mo_message and !mo_message.blank? and mo_message.include? CHARACTER_ID and mo_message.scan(/\[([^\]]+)\]/).last and mo_message.scan(/\[([^\]]+)\]/).last.first
      character_id = mo_message.scan(/\[([^\]]+)\]/).last.first
      #character = Character.where("id = ?",character_id)
      begin
        character = Character.find(character_id)

        sms_request = SmsRequest.new
        sms_request.access_key = params[:access_key]
        sms_request.command = params[:command]
        sms_request.mo_message = mo_message
        sms_request.msisdn = params[:msisdn]
        sms_request.request_id = params[:request_id]
        sms_request.request_time = params[:request_time]
        sms_request.short_code = params[:short_code]
        sms_request.signature = params[:signature]
        sms_request.character = character
        sms_request.save

        character.life = character.life + 3
        if character.save!
          render :status => 200,
                 :json => {
                     :status => 1,
                      :sms => "Ban da mua thanh cong",
                      :type =>"confirm"
                 }
        else
          render :status => 200,
                 :json => {
                     :status => 0,
                     :sms => "Ban da mua that bai",
                     :type =>"confirm"
                 }
        end
      rescue ActiveRecord::RecordNotFound => e
        #render_json_error 417,e.message
        render :json => {
            :status => 0,
            :sms => "Ban da mua that bai",
            :type =>"confirm"
        }
      end
    else
      render :status => 200,
             :json => {
                 :status => 0,
                 :sms => "Ban da mua that bai",
                 :type =>"confirm"
             }
    end
  end

#--------------------------------Item API -------------------
  def list_user_item
    #item_groups = ItemGroup.joins(:item_types).joins(:items).where('items.character_id = ?', params[:character_id])
    #item_groups = ItemGroup.joins(:item_types).joins(:user_items).where('user_items.character_id = ?', current_user.character.id)
    user_items = UserItem.where('user_items.character_id = ?', current_user.character.id)
    render :status => 200,
           :json => {:success => true,
                     :data => user_items.as_json({:root_path => root_url})
           }
  end

  def upgrade_item

    if current_user.character.gem.nil? or current_user.character.gem.blank?
      current_user.character.gem = 0
    end
    if current_user.character.gold.nil? or current_user.character.gold.blank?
      current_user.character.gold = 0
    end
    user_item = UserItem.find(params[:upgrade_item][:item_id])

    if (params[:upgrade_item][:method] == 'gold' and  current_user.character.gold < item.gold) or
        (params[:upgrade_item][:method] == 'gem' and  current_user.character.gem < item.gem)
      render_json_error("404", "User don't have enough #{params[:buy_item][:method]} to upgrade this item!")
      return;
    end
    item = Item.where('level = ? and name = ?',user_item.level+1, user_item.name).first

    if item
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
      user_item.item_group = item.item_group
      user_item.item_type = item.item_type

      UserItem.transaction do
        begin
          if user_item.save
            if params[:upgrade_item][:method] == 'gold'
              current_user.character.gold = current_user.character.gold - item.gold
            elsif params[:upgrade_item][:method] == 'gem'
              current_user.character.gem = current_user.character.gem - item.gem
            end

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
          render_json_error("422", e.messages)
        end
      end
    else
      render_json_error("422", "Item can't upgraded!")
    end
  end

  def fixing_item
    user_item = UserItem.find(params[:fixing_item][:item_id])
    pc_health = user_item.cur_health/user_item.health
    #TODO:need calculation logic for calculate prize fix item
  end

  def list_items_by_group
    items = Item.joins(:item_type).where('item_types.name = ?', params[:item_type_name])
    if params[:item_type_name] == 'Skills'
        items.each do |item|
          if item.gold.nil? or item.gold.blank?
            item.gold = 0
          end

          if item.gem.nil? or item.gem.blank?
            item.gem = 0
          end
          if current_user.character
            item.gold = item.gold*current_user.character.lv
            item.gem = item.gem*current_user.character.lv
          end
        end
    end

    render :status => 200,
           :json => {:success => true,
                     :data => items.as_json({:root_path => root_url})
           }
  end


  def buy_items
    item_ids_array =[]
    params[:buy_item][:item_ids].each do |item_id|
      if item_id.match('-')
        item_ids_array.push(UUIDTools::UUID.parse(item_id))
      else
        item_ids_array.push(UUIDTools::UUID.parse_hexdigest(item_id))
      end

    end

    #UUIDTools::UUID.parse_hexdigest(params[:buy_item][:item_ids][0])
    items = Item.where('items.id in (?)',item_ids_array)

    if items and items.size != 0
      if params[:buy_item][:method] == 'gold'
        total_gold_diff_Skills = Item.includes(:item_type).where('items.id in (?) and item_types.name != ?',item_ids_array,'Skills').sum(:gold)
        total_gold_Skills = Item.includes(:item_type).where('items.id in (?) and item_types.name = ?',item_ids_array,'Skills').sum(:gold)
        total_gold_Skills = total_gold_Skills*current_user.character.lv
        total_gold = total_gold_diff_Skills + total_gold_Skills
        if current_user.character.gold >= total_gold

          UserItem.transaction do
            begin
              items.each do |item|
                if item.permanent == true
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
                  user_item.item_group = item.item_group
                  user_item.item_type = item.item_type
                  user_item.permanent = item.permanent
                  user_item.item = item
                  user_item.save
                end
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
        total_gem = Item.where('items.id in (?)',item_ids_array).sum(:gem)
        if current_user.character.gem >= total_gem

          UserItem.transaction do
            begin
              items.each do |item|
                if item.permanent == true
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
                  user_item.item_group = item.item_group
                  user_item.item_type = item.item_type
                  user_item.permanent = item.permanent
                  user_item.item = item
                  user_item.save
                end
              end

              current_user.character.gem = current_user.character.gem - total_gem
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
          render_json_error("404", "User don't have enough gem to buy these items!")
        end
      else
        render_json_error("422", "Action not complete!")
      end
    else
      render_json_error("422", "you don't choose any item")
    end
  end

  def buy_item
    if current_user.character.gem.nil? or current_user.character.gem.blank?
      current_user.character.gem = 0
    end
    if current_user.character.gold.nil? or current_user.character.gold.blank?
      current_user.character.gold = 0
    end

    item = Item.find(params[:buy_item][:item_id])

    if (params[:buy_item][:method] == 'gold' and  current_user.character.gold < item.gold) or
       (params[:buy_item][:method] == 'gem' and  current_user.character.gem < item.gem)
      render_json_error("404", "User don't have enough #{params[:buy_item][:method]} to buy this item!")
      return;
    end

    if item.permanent == true

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
      user_item.item_group = item.item_group
      user_item.item_type = item.item_type
      user_item.permanent = item.permanent
      user_item.item = item


      UserItem.transaction do
        begin
          if user_item.save
            if params[:buy_item][:method] == 'gold'
              current_user.character.gold = current_user.character.gold - item.gold
            elsif params[:buy_item][:method] == 'gem'
              current_user.character.gem = current_user.character.gem - item.gem
            end

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
      #only update gold and gem of user
      if params[:buy_item][:method] == 'gold'
        current_user.character.gold = current_user.character.gold - item.gold
      elsif params[:buy_item][:method] == 'gem'
        if current_user.character.gem
          current_user.character.gem = current_user.character.gem - item.gem
        else
          current_user.character.gem = 0
        end

      end

      if current_user.character.save
        render :status => 200,
               :json => {:success => true,
                         :data => "Buy item success!"
               }
      else
        render_json_error("422", current_user.character.errors)
      end
    end

  end
end