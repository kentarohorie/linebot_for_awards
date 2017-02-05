require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, 'log/cron.log'

every 5.minute do
  User.all.each do |user|
    user.love = user.love - 1
    user.save
  end
end