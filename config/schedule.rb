every 6.hours do
  User.all.each do |user|
    user.love = user.love - 1
    user.save
  end
end