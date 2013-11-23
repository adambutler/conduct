class Idea < ActiveRecord::Base

  has_many :votes

  def self.qty_on(date)
    where("date(created_at) = ?",date).count
  end
  
end
