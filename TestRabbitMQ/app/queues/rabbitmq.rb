class Rabbitmq
  def self.channel
    @channel ||= connection.create_channel
  end

  def self.connection
    @connection || Bunny.new(hostname: "192.168.59.103").tap do |c|
      c.start
    end
  end
end