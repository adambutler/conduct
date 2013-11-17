class Topic < ActiveRecord::Base

  after_save :generate_secret

  private

  def generate_secret
    update_column(:secret, Digest::MD5.hexdigest("#{created_at}#{id}hammertime")) 
  end
end
