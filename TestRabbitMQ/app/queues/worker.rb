class Worker
  def self.work
    subscribe do |body|
      processor(body)
    end
  end

  def self.subscribe
    q = channel.queue("post", durable: true)
    channel.prefetch(1)
    puts "等待消息，CTRL+C 退出"
    begin
      q.subscribe(manual_ack: true, block: true) do |delivery_info, properties, body|
        yield(body)
        channel.ack(delivery_info.delivery_tag)
      end
    rescue Interrupt => _
      Rabbitmq.connection.close
    end
  end

  def self.channel
    Rabbitmq.channel
  end

  def self.processor(body)
    puts "Start..."
    sleep 20
    puts "接收 #{eval(body)[:key]}"
    puts "Done"
  end
end