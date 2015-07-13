require 'bunny'

conn = Bunny.new(hostname: "192.168.59.103")
conn.start

channel = conn.create_channel
exchange = channel.fanout("logs")
msg = ARGV.empty? ? "Hi" : ARGV.join(" ")
exchange.publish(msg)
puts " [x] Sent #{msg}"
conn.close