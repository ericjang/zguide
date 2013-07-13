#    
# Weather update server in Julia
# Binds PUB socket to tcp://*5556
# Publishes random weather updates
# 
# Author: Eric Jang 2013-07-04 <eric_jang(at)brown(dot)edu> 
using ZMQ

context = ZMQContext(1)
socket = ZMQSocket(context, ZMQ_PUB)
ZMQ.bind(socket, "tcp://*:5556")

println("starting...")

while true
	zipcode = rand(1:10000)
	temperature = rand(1:215) - 80
	relhumidity = rand(1:50) + 10
	message = string(zipcode, " ", temperature, " ", relhumidity)
	println(message)
	ZMQ.send(socket, ZMQMessage(message))
end
