class ResponsesController < ApplicationController
  CHANNEL_SECRET = "3f46876f880a741ee8dd0453ed433cd5"
  CHANNEL_ACCESS_TOKEN = "V1nZVaGmdYgECu+jOw5My+tbeV0DoApp5d1cPsA5cg2YqOLkLxOD6Bd4TiCFjF4vj6VyTlaS9+S+a3qY+Zpr5YJOLkABHyqhv+7W38IO2+z4cTPQeFTCp3BK2aVOTRxuIVVIP8sF8sXZbUF7PI0xtgdB04t89/1O/w1cDnyilFU="

  def callback
    binding.pry
    puts params
  end
end
