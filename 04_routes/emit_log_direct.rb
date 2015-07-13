require 'bunny'

conn = Bunny.new(hostname: "192.168.59.103")
conn.start

ch = conn.create_channel
x = ch.direct("direct_logs")
severity = ARGV.shift || "info"
msg = ARGV.empty? ? "Hi" : ARGV.join(" ")

x.publish(msg, routing_key: severity)
p "Sent '#{msg}"
conn.close