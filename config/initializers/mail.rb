
# This is needed for using sendgrid on heroku

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'at0m4eg@gmail.com',
  :password       => '*****'
}
ActionMailer::Base.delivery_method ||= :smtp
