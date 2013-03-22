class UserMailer < ActionMailer::Base
  default from: "at0m4eg@gmail.com"

  def welcome_email(user)
    @user = user
    #@url  = "http://at0m4eg@gmail.com/login"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end

