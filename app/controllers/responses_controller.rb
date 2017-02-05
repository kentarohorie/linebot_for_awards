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
    postback = params[:events][0][:postback]

    if is_death(user)
      output_text = "あなたのnyaineは死んでしまいました。"
      reply_text(output_text, reply_token)
    elsif postback != nil && postback[:data] == "panchi"
      message = {
        type: "image",
        originalContentUrl: "https://cyac.com/sites/default/files/teams/2006010210_1113818290.jpg",
        previewImageUrl: "https://cyac.com/sites/default/files/teams/2006010210_1113818290.jpg"
      }
      client.reply_message("#{reply_token}", message)
      if rand(4) == 0
        user.love = -100
        user.save
        reply_text("nyaineが攻撃をうけた！", reply_token)
      else
        reply_text("倒したにゃ！レベルアップにゃ〜♡", reply_token)
      end
    # elsif params[:events][0][:postback][:data] == "sleep"
    #   message = {
    #     type: "image",
    #     originalContentUrl: "https://rr.img.naver.jp/mig?src=http%3A%2F%2Fpds.exblog.jp%2Fpds%2F1%2F200907%2F18%2F94%2Fd0128594_20534369.jpg&twidth=1000&theight=0&qlt=80&res_format=jpg&op=r",
    #     previewImageUrl: "https://rr.img.naver.jp/mig?src=http%3A%2F%2Fpds.exblog.jp%2Fpds%2F1%2F200907%2F18%2F94%2Fd0128594_20534369.jpg&twidth=1000&theight=0&qlt=80&res_format=jpg&op=r"
    #   }
    #   client.reply_message("#{reply_token}", message)
    #   if rand(4) == 0
    #     user.love = -100
    #     user.save
    #     reply_text("nyaineが攻撃をうけた！", reply_token)
    #   else
    #     reply_text("倒したにゃ！レベルアップにゃ〜♡", reply_token)
    #   end
    elsif is_monster
      puts "hogehogehogehogehogehogehogehogehogehogehogehogehogeho"
      reply_content = {
        type: "template",
        altText: "button tamplate",
        template: {
          type: "buttons",
          thumbnailImageUrl: "https://iwiz-chie.c.yimg.jp/im_siggAK7pHbPWXj37beJ3TaWQoQ---x320-y320-exp5m-n1/d/iwiz-chie/que-13118373208",
          title: "モンスターが現れたにゃ！",
          text: "a",
          actions: [
            {
              type: "postback",
              label: "猫パンチ",
              data: "panchi"
            },
            {
              type: "postback",
              label: "ごめん寝",
              data: "sleep"
            }
          ]
        }
      }
      client.reply_message("#{reply_token}", reply_content)
    elsif event_type == "message"
      input_text = event[:message][:text]
      if input_text.match("えさ") || input_text.match("エサ") || input_text.match("餌")
        up_love(user, true)
        output_text = "えさだにゃ〜〜"
      else
        up_love(user, false)
        if (0..10).cover?(user.love)
          output_text = Settings.serif.a[rand(11)]
        elsif (0..10).cover?(user.love)
          output_text = Settings.serif.b[rand(11)]
        elsif (11..20).cover?(user.love)
          output_text = Settings.serif.c[rand(11)]
        elsif (21..30).cover?(user.love)
          output_text = Settings.serif.d[rand(11)]
        elsif (31..40).cover?(user.love)
          output_text = Settings.serif.e[rand(11)]
        elsif (41..50).cover?(user.love)
          output_text = Settings.serif.f[rand(11)]
        elsif (51..60).cover?(user.love)
          output_text = Settings.serif.g[rand(11)]
        elsif (71..70).cover?(user.love)
          output_text = Settings.serif.h[rand(11)]
        elsif (81..90).cover?(user.love)
          output_text = Settings.serif.i[rand(11)]
        else
          output_text = Settings.serif.j[rand(11)]
        end
      end
      reply_text(output_text, reply_token)
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

  def is_death(user)
    if user.love < 0
      return true
    else
      return false
    end
  end

  def is_monster
    rand(4) == 0
  end

  def reply_text(text, token)
    message = {
        type: "text",
        text: text
      }

      client.reply_message("#{token}", message)
  end
end
