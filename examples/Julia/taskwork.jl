# Task worker
# Connects PULL socket to tcp://localhost:5557
# Collects workloads from ventilator via that socket
# Connects PUSH socket to tcp://localhost:5558
# Sends results to sink via that socket
#
# Author: Eric Jang 2013-07-04 <eric_jang(at)brown(dot)edu> 

using ZMQ

context = ZMQContext(1)

# Socket to receive messages on
receiver = ZMQSocket(context, ZMQ_PULL)
ZMQ.connect(receiver, "tcp://localhost:5557")

# Socket to send messages to
sender = ZMQSocket(context, ZMQ_PUSH)
ZMQ.connect("tcp://localhost:5558")

# Process tasks forever
while true
	s = ZMQ.recv(receiver)
	# Simple progress indicator for the viewer
	print('.')
	# do the work
	sleep(1)
	# send results to sink
	ZMQ.send(sender, '')	
end