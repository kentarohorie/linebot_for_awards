class ResponsesController < ApplicationController
  require 'line/bot'
  skip_before_filter :verify_authenticity_token
  CHANNEL_SECRET = ENV['SECRET']
  CHANNEL_ACCESS_TOKEN = ENV['TOKEN']

  def callback
    event = params[:events][0]
    event_type = event[:type]
    reply_token = event[:replyToken]
    output_text = ""
    user = find_or_create_user

    case event_type
    when "message"
      input_text = event[:message][:text]
      if input_text.match("えさ") || input_text.match("エサ") || input_text.match("餌")
        up_love(user, true)
        output_text = "えさだにゃ〜〜"
      else
        up_love(user, false)
        output_text = "にゃんだにゃ〜？"
      end
      message = {
        type: "text",
        text: output_text
      }

      client.reply_message("#{reply_token}", message)
    end
  end

  private
  def client
    @client = Line::Bot::Client.new { |config|
      config.channel_secret = CHANNEL_SECRET
      config.channel_token = CHANNEL_ACCESS_TOKEN
    }
  end

  def find_or_create_user
    user_id = params[:events][0][:source][:userId]
    if user = User.find_by_user_id(user_id)
      return user
    else
      User.create(user_id: user_id)
    end
  end

  def up_love(user, is_feed)
    if is_feed
      user.love = user.love += 10
    else
      user.love = user.love += 4
    end
    user.save
  end
end
