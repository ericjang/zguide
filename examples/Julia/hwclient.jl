# Hello World client in Julia
# Connects REQ socket to tcp://localhost:5555
# Sends "Hello" to server, expects "World" back
#    
# Author: Eric Jang 2013-07-04 <eric_jang(at)brown(dot)edu> 

using ZMQ

context = ZMQContext(1)
socket = ZMQSocket(context, ZMQ_REQ)
println("Connecting to Hello World server...")
ZMQ.connect(socket, "tcp://localhost:5555")

#Do 10 requests, waiting each time for a response
for request_nbr = 1:10
	ZMQ.send(socket, ZMQMessage("Hello"))
	println(string("Sending Hello ", request_nbr, "..."))
	#get the reply
	reply = ZMQ.recv(socket)
	println(string("Received: ", ASCIIString[reply], " ", request_nbr))
end

#Close the sockets
ZMQ.close(socket)
ZMQ.close(context)
