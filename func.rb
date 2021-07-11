require 'fdk'
require 'twitter'

def myfunction(context:, input:)
  input_value = input.respond_to?(:fetch) ? input.fetch('msg') : input
  
  now = Time.now.localtime("+09:00").strftime("%Y-%m-%d %H:%M:%S")
  default_msg = "ただいまの時刻は #{now} です。"

  msg = input_value.to_s.strip.empty? ? default_msg : input_value

  @client = ::Twitter::REST::Client.new(
        consumer_key: ENV["CONSUMER_KEY"],
        consumer_secret: ENV["CONSUMER_SECRET"],
        access_token: ENV["ACCESS_TOKEN"],
        access_token_secret: ENV["ACCESS_TOKEN_SECRET"]
  )


  update = @client.update msg

  update.to_h
end

FDK.handle(target: :myfunction)
