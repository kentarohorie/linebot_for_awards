class ResponsesController < ApplicationController
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
      client.reply_message(replyToken, output_text)
    end


    render :nothing: true, status: :ok
  end

  private
  def client
    @client = Line::Bot::Client.new { |config|
      config.channel_secret = CHANNEL_SECRET
      config.channel_token = CHANNEL_ACCESS_TOKEN
    }
  end
end


# {"events"=>[{"type"=>"message", "replyToken"=>"502a44ba9eea43eebea4adff9934cccd", "source"=>{"userId"=>"U9b43688bcf372dc00a22d3c55b5047f5", "type"=>"user"}, "timestamp"=>1486192444261, "message"=>{"type"=>"text", "id"=>"5598590318240", "text"=>"あ"}}], "response"=>{"events"=>[{"type"=>"message", "replyToken"=>"502a44ba9eea43eebea4adff9934cccd", "source"=>{"userId"=>"U9b43688bcf372dc00a22d3c55b5047f5", "type"=>"user"}, "timestamp"=>1486192444261, "message"=>{"type"=>"text", "id"=>"5598590318240", "text"=>"あ"}}]}}