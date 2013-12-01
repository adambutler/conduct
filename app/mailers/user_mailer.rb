class UserMailer < ActionMailer::Base
  default from: "adam@conduct.io"

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Conduct.io | Password Reset"
  end
end
