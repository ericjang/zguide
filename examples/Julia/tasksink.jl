# Task sink
# Binds PULL socket to tcp://localhost:5558
# Collects results from workers via that socket
#
# Author: Eric Jang 2013-07-04 <eric_jang(at)brown(dot)edu> 

using ZMQ

context = ZMQContext(1)
receiver = ZMQSocket(context, ZMQ_PULL)
ZMQ.bind(receiver, "tcp://*:5558")

# Wait for start of batch
message = ZMQ.recv(socket)

# Start our clock now

# Process 100 confirmations

# Calculate and report duration of batch

