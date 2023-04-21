require 'sinatra'
require 'pony'

Pony.options = {
  :from => 'kasper@kasper.com',
  :to => 'artule@gmail.com',
  :via => :smtp,
  :via_options => {
    :address => 'sandbox.smtp.mailtrap.io',
    :port => '2525',
    :user_name => '966335c618f384',
    :password => '009533a65a95b2',
    :authentication => :cram_md5,
    :domain => 'kasper.com'
  }
}


get '/sendmail' do
  subject = 'Email Tester by Sinatra + Pony '
  body = 'Hey Kasper =)'
  
  Pony.mail({
    :subject => subject,
    :body => body
  })

  p 'check your mailbox =)'
end
