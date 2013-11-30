class Idea < ActiveRecord::Base

  has_many :votes
  belongs_to :idea, foreign_key: "secret"

  def self.qty_on(date)
    where("date(created_at) = ?",date).count
  end
  
end
