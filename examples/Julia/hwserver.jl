# Hello World server in Julia
# Binds REP socket to tcp://*5555
# Expects "Hello" from client, replies with "World"
#    
# Author: Eric Jang 2013-07-04 <eric_jang(at)brown(dot)edu> 

using ZMQ

context = ZMQContext(1)
socket = ZMQSocket(context, ZMQ_REP)
ZMQ.bind(socket, "tcp://*:5555")

while true
	# Wait for next request from client
	request = ZMQ.recv(socket)
	println("Received Hello")
	# Do some 'work'
	sleep(1)
	# Send reply back to client
	ZMQ.send(socket, ZMQMessage("World"))
end