# encoding: utf-8
require 'bunny'

conn = Bunny.new(hostname: "192.168.59.103")
conn.start

ch = conn.create_channel
q = ch.queue("task_queue", durable: true)
msg = ARGV.empty? ? "Hello LG!" : ARGV.join(" ")

q.publish(msg, persistent: true)
puts " [X] Sent #{msg}"
sleep 1.0
conn.close