require "bunny"

conn = Bunny.new(:hostname => "192.168.59.103",:automatically_recover => false)
conn.start

ch   = conn.create_channel
q    = ch.queue("hello")

begin
  puts " [*] Waiting for messages. To exit press CTRL+C"
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] Received #{body}"
  end
rescue Interrupt => _
  conn.close
  exit(0)
end

#puts " [*] Waiting for messages. To exit press CTRL+C"
# q.subscribe(block: true) do |delivery_info, properties, body|
#   p delivery_info
#   p properties
#   p body
#   delivery_info.consumer.cancel
# end

# begin
#   delivery_info, properties, body = q.pop
#   p body if body
# rescue Interrupt => _
#   conn.close
#   exit(0)
# end

