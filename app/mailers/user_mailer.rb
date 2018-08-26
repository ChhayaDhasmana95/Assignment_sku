class UserMailer < ApplicationMailer
 

  def confirmation_email(user)
    @user = user
    @email = @user.email
    mail to: @user.email,subject: "Confirmation Email"
  end

end
