require 'bunny'

conn = Bunny.new(hostname: "192.168.59.103")
conn.start

channel = conn.create_channel
exchange = channel.fanout("logs")
q = channel.queue("",exclusive: true)

q.bind(exchange)

puts "等待消息，CTRL+C 退出"
begin
  q.subscribe(block: true) do |delivery_info, properties, body|
    puts body
  end
rescue Interrupt => _
  channel.close
  conn.close
end