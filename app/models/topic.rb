class Topic < ActiveRecord::Base

  after_save :generate_secret
  has_many :ideas, :primary_key => "secret"
  private

  def generate_secret
    update_column(:secret, Digest::MD5.hexdigest("#{created_at}#{id}hammertime")) 
  end

end
