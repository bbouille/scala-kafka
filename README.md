Description
===========

Quick up and running using Scala for Apache Kafka.

Software versions used in the boxes :
* Type: Virtual Box (from [vagrantcloud.com/ffuenf](https://vagrantcloud.com/ffuenf/debian-7.4.0-amd64))
* OS: Debian 7.4 x64 
* kafka 0.8.1
* Scala 2.10
* Java 1.7

Box number : 2
* 1 for the broker (1cpu / 1024mo / 10Go)
* 1 for the zookeeper (1cpu / 512mo / 10Go)

Requirements
===========

Use Vagrant to get up and running.

1. Install Vagrant [http://www.vagrantup.com/](http://www.vagrantup.com/)  
2. Install Virtual Box [https://www.virtualbox.org/](https://www.virtualbox.org/)  

Installation 
===========

Clone this repository in your home folder for example :

	cd ~
	git clone https://github.com/isnoopy/scala-kafka.git


Fire up 
===========

Go to to scala-kafka foler and start the VMs : 

	cd scala-kafka
	vagrant up

once this is done 
* One zookeeper node 'zk1' is running on 192.168.10.20 (listening on port 2181)
* One broker 'k1' is running on 192.168.10.21 (listening on port 9092)

You can see VM status with :
	vagrant status
	Current machine states:

	zk1                       running (virtualbox)
	k1                        running (virtualbox)

If you want you can login to the machines using 'vagrant ssh <machineName>' (zk1 or k1) but you don't need to.

Run the tests
===========

* All the tests in src/test/scala/* should pass :

	./sbt test 

	[...]

	[info] Total for specification KafkaSpec
	[info] Finished in 33 ms
	[info] 3 examples, 0 failure, 0 error
	[info] Passed: Total 3, Failed 0, Errors 0, Passed 3
	[success] Total time: 5 s, completed 11 avr. 2014 16:50:36

You can access the brokers and zookeeper by their IP from your local network without having to go into vm.

	bin/kafka-console-producer.sh --broker-list 192.168.10.20:9092 --topic <get his from the random topic created in test>

	bin/kafka-console-consumer.sh --zookeeper 192.168.10.21:2181 --topic <get his from the random topic created in test> --from-beginning

Shuting down
===========
* Shutdown all the VM from the scala-kafka folder :

	vagrant destroy
