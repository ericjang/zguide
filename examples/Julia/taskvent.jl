# Task ventilator
# Binds PUSH socket to tcp://localhost:5557
# Sends batch of tasks to workers via that socket
#
# Author: Eric Jang 2013-07-04 <eric_jang(at)brown(dot)edu> 

using ZMQ

context = ZMQContext(1)
# Socket to send messages on
socket = ZMQSocket(context, ZMQ_PUSH)
ZMQ.bind(socket, "tcp://*:5557")

# Socket with direct access to the sink: used to synchronize 
# start of the batch
sink = ZMQSocket(context, ZMQ_PUSH)
ZMQ.connect(sink, "tcp://localhost:5558")

println("Press Enter when the workers are ready:")
readline(STDIN)
println("Sending tasks to workers...")

# The first message is "0" and signals start of batch
ZMQ.send(sink, '0')

# Send 100 tasks
total_msec = 0
for task_nbr = 1:100
	#random workload from 1 to 100 msec
	workload = rand(1:100)
	total_msec += workload
	ZMQ.send(string(workload))
end

println(string("Total expected cost: ", total_msec, " msec"))

# Give 0MQ time to deliver
sleep(1)

