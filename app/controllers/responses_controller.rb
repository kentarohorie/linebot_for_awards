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
        if (0..10).cover?(user.love)
          output_text = Settings.serif.a[rand(10)]
        elsif (0..10).cover?(user.love)
          output_text = Settings.serif.b[rand(10)]
        elsif (11..20).cover?(user.love)
          output_text = Settings.serif.c[rand(10)]
        elsif (21..30).cover?(user.love)
          output_text = Settings.serif.d[rand(10)]
        elsif (31..40).cover?(user.love)
          output_text = Settings.serif.e[rand(10)]
        elsif (41..50).cover?(user.love)
          output_text = Settings.serif.f[rand(10)]
        elsif (51..60).cover?(user.love)
          output_text = Settings.serif.g[rand(10)]
        elsif (71..70).cover?(user.love)
          output_text = Settings.serif.h[rand(10)]
        elsif (81..90).cover?(user.love)
          output_text = Settings.serif.i[rand(10)]
        else
          output_text = Settings.serif.j[rand(10)]
        end
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
