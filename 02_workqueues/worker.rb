# encoding: utf-8
require 'bunny'

conn = Bunny.new(hostname: "192.168.59.103")
conn.start

ch = conn.create_channel
q = ch.queue("task_queue", durable: true)
ch.prefetch(1)
puts "等待消息，CTRL+C 退出"

begin
  q.subscribe(manual_ack: true, block: true) do |delivery_info, properties, body|
    puts "接收 #{body}"
    sleep body.count(".").to_i
    puts "Done"
    ch.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  conn.close
end