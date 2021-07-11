require 'fdk'
require 'twitter'

def myfunction(context:, input:)
  input_value = input.respond_to?(:fetch) ? input.fetch('name') : input
  name = input_value.to_s.strip.empty? ? 'World' : input_value
  #FDK.log(entry: "Inside Ruby Hello World function")
  { message: "Hello #{name}!" }

  @client = ::Twitter::REST::Client.new(
        consumer_key: ENV["CONSUMER_KEY"],
        consumer_secret: ENV["CONSUMER_SECRET"],
        access_token: ENV["ACCESS_TOKEN"],
        access_token_secret: ENV["ACCESS_TOKEN_SECRET"]
  )

  now = Time.now.localtime("+09:00").strftime("%Y-%m-%d %H:%M:%S")

  update = @client.update "ただいまの時刻は #{now} です。"

  update.to_h
end

FDK.handle(target: :myfunction)
