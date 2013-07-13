#    
# Weather update client in Julia
# Binds SUB socket to tcp://localhost:5556
# Collects weather updates and finds avg temp in zipcode
# 
# Author: Eric Jang 2013-07-04 <eric_jang(at)brown(dot)edu> 

using ZMQ

# Socket to talk to server
context = ZMQContext(1)
socket = ZMQSocket(context, ZMQ_SUB)
println("Collecting updates from weather server...")
ZMQ.connect(socket, "tcp://localhost:5556")

# Subscribe to zipcode, default is NYC 10001
if length(ARGS) == 1
	zipcode = ARGS[1]
else
	zipcode = "10001"
end
ZMQ.set_subscribe(socket, zipcode)

# Process 5 updates
total_temp = 0
for update_nbr = 1:5
	reply = ZMQ.recv(socket)
	string = ASCIIString[reply]
	(zipcode, temperature, relhumidity) = split(string)
	total_temp += int(temperature)
	println(update_nbr)
end
	
println(string("Average temperature for zipcode ", zipcode, " was ", total_temp/5, "F"))



