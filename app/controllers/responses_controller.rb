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
    case event_type
    when "message"
      input_text = event[:message][:text]
      output_text = input_text
      message = {
        type: "text",
        text: output_text
      }
      puts "hogehoeghogehoge"
      client.reply_message("#{reply_token}", message)
      puts "piyopiyo"
    end
  end

  private
  def client
    @client = Line::Bot::Client.new { |config|
      config.channel_secret = CHANNEL_SECRET
      config.channel_token = CHANNEL_ACCESS_TOKEN
    }
    puts '-----------------------------------------'
    return @client
  end
end
