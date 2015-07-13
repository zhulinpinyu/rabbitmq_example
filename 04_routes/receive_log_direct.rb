require 'bunny'

if ARGV.empty?
 abort "Usage: #{$0}[info][warning][error]"
end


conn = Bunny.new(hostname: "192.168.59.103")
conn.start

ch = conn.create_channel
x = ch.direct("direct_logs")
q = ch.queue('',exclusive: true)

ARGV.each do |s|
  q.bind(x, routing_key: s)
end

p "Watting logs, CTRL+C exit"

begin
  q.subscribe(block: true) do |delivery_info,properties,body|
    p "#{delivery_info.routing_key}: #{body}"
  end
rescue Interrupt => _
  ch.close
  conn.close
end
