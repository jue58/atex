require 'discordrb'

class DiscordBot
  def initialize(token:, channel:)
    @conn = Discordrb::Bot.new(token: token)
    @channel = channel
  end

  def send_message(message)
    @conn.send_message(@channel, message)
  end
end