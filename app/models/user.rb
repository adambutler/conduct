class User < ActiveRecord::Base
  
  has_secure_password(validations: false)
  validates_uniqueness_of :email

  def access_token_reset
    generate_token(:access_token, 24)
    save!
  end

  def send_password_reset
    generate_token(:password_reset_token)
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column, length = 6)
    begin
      self[column] = rand(36**length).to_s(36)
    end while User.exists?(column => self[column])
  end

end
