include ApplicationHelper

class Topic < ActiveRecord::Base

  belongs_to :user

  has_many :ideas, :primary_key => "secret"
  after_create :generate_secret

  def to_param
    secret
  end
  
  private

  def generate_secret
    begin
      self[:secret] = generate_token(6)
    end while Topic.exists?(:secret => self[:secret])
    save!
  end

end
