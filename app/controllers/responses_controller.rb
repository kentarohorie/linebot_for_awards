class ResponsesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  CHANNEL_SECRET = "3f46876f880a741ee8dd0453ed433cd5"
  CHANNEL_ACCESS_TOKEN = "V1nZVaGmdYgECu+jOw5My+tbeV0DoApp5d1cPsA5cg2YqOLkLxOD6Bd4TiCFjF4vj6VyTlaS9+S+a3qY+Zpr5YJOLkABHyqhv+7W38IO2+z4cTPQeFTCp3BK2aVOTRxuIVVIP8sF8sXZbUF7PI0xtgdB04t89/1O/w1cDnyilFU="

  def callback
    event = params[:events][0]
    event_type = event[:type]
    reply_token = event[:replyToken]
    output_text = ""
    case event_type
    when "message"
      input_text = event[:message][:text]
      output_text = input_text
      message = {
        type: "text",
        text: output_text
      }
      puts "~=~=~=~=~=~=~="
      client
      client.methods
      puts "~=~=~=~=~=~=~="

      client.reply_message("#{reply_token}", message)
    end

    # render json: {}, status: :ok
  end

  private
  def client
    @client = Line::Bot::Client.new { |config|
      config.channel_secret = CHANNEL_SECRET
      config.channel_token = CHANNEL_ACCESS_TOKEN
    }
  end
end

