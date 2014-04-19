# Description

Quick up and running using Scala for Apache Kafka.

Software versions used in each box (virtual machine running locally) :

-   Type: Virtual Box (from [ffuenf][])

-   OS: Debian 7.4 x64

-   kafka 0.8.1

-   Scala 2.10

-   Java 1.7

-   Ganglia 3.5.8 / Ganglia-web 3.5.12

Box details :

-   1 box for the broker (1cpu / 1024mo / 10Go)

-   1 box for the zookeeper (1cpu / 512mo / 10Go)

# Requirements

Use Vagrant to get up and running :

1.  Install Vagrant <http://www.vagrantup.com/>

2.  Install Virtual Box <https://www.virtualbox.org/>

# Installation

Clone this repository in your home folder for example :

    cd ~
    git clone https://github.com/isnoopy/scala-kafka.git

# Fire up

Go to to scala-kafka foler and start the VMs :

    cd scala-kafka
    vagrant up

Once this is done (\~10min) :

-   One zookeeper node 'zk1' is running on 192.168.10.20 (listening on
    port 2181)

-   One broker 'k1' is running on 192.168.10.21 (listening on port 9092)

You can see VM status with :

    vagrant status

Current machine states:

    zk1                       running (virtualbox)
    k1                        running (virtualbox)

If you want you can login to the machines using 'vagrant ssh ' (zk1 or
k1) but you don't need to.

# Run the tests

All the tests in src/test/scala/\* can be run with :

    ./sbt test 

and should pass :

    [info] Total for specification KafkaSpec
    [info] Finished in 33 ms
    [info] 3 examples, 0 failure, 0 error
    [info] Passed: Total 3, Failed 0, Errors 0, Passed 3
    [success] Total time: 5 s, completed 11 avr. 2014 16:50:36

You can access the brokers and zookeeper by their IP from your local
network without having to go into vm.

    bin/kafka-console-producer.sh --broker-list 192.168.10.20:9092 --topic <get his from the random topic created in test>

    bin/kafka-console-consumer.sh --zookeeper 192.168.10.21:2181 --topic <get his from the random topic created in test> --from-beginning

# Check box load and health

Using Ganglia for monitoring ([more details][ffuenf]), you can check
each VM ressource consumption (CPU, RAM, HD) at
<http://192.168.10.21/ganglia> in your favorite browser.

![alt tag](docs/img/ganglia.png)

# Shuting down (suspend)

Shutdown all (suspend execution) the VM from the scala-kafka folder :

    vagrant halt

    ==> zk1: Attempting graceful shutdown of VM...
    ==> k1: Attempting graceful shutdown of VM...

# Resume (restart)

Resume (recover execution) the VM from the scala-kafka folder :

    vagrant up

# Clean up

To completly stop and remove all the VM files :

    vagrant destroy

        k1: Are you sure you want to destroy the 'k1' VM? [y/N] y
    ==> k1: Destroying VM and associated drives...
    ==> k1: Running cleanup tasks for 'shell' provisioner...
    ==> k1: Running cleanup tasks for 'shell' provisioner...
        zk1: Are you sure you want to destroy the 'zk1' VM? [y/N] y
    ==> zk1: Destroying VM and associated drives...
    ==> zk1: Running cleanup tasks for 'shell' provisioner...
    ==> zk1: Running cleanup tasks for 'shell' provisioner...

More on vagrant tools :
[http://docs.vagrantup.com/v2/getting-started/teardown.html][ffuenf]

  [ffuenf]: #
  []: docs/img/ganglia.png
