class Publisher
  def self.publish(msg = {})
    q = Rabbitmq.channel.queue("post", durable: true)
    q.publish(msg.to_s, persistent: true)
    Rabbitmq.connection.close
  end
end