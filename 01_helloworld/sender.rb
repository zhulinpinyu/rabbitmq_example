require "bunny"

conn = Bunny.new(:hostname => "192.168.59.103",:automatically_recover => false)
conn.start

ch   = conn.create_channel
q    = ch.queue("hello")

ch.default_exchange.publish("Hello World!", :routing_key => q.name)
p "Queue: #{q.name}"
puts " [x] Sent 'Hello World!'"

conn.close