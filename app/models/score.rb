class Score < ActiveRecord::Base
  include ActiveUUID::UUID
  belongs_to :character
  belongs_to :user
  attr_accessible :character_id, :score, :time_stamp,:score_type

  def self.search(search)
    if search  and search.strip != ''
      joins(:character).where('characters.char_name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def ranking(after_time)
    if after_time  and after_time.strip != ''
      Score.count(:conditions => ['score > ? and created_at >= ?', self.score, after_time])
    else
      Score.count(:conditions => ['score > ?', self.score])
    end
  end

  def self.maximum_score(char_id,after_time)
    if after_time  and after_time.strip != ''
      where('character_id = ? and created_at >= ?',char_id, after_time).order("score DESC").first
    else
      where('character_id = ?',char_id).order("score DESC").first
    end

  end
end
