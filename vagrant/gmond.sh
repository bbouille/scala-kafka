# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/sh -Eux

#  Trap non-normal exit signals: 1/HUP, 2/INT, 3/QUIT, 15/TERM, ERR
trap founderror 1 2 3 15 ERR

founderror()
{
        exit 1
}

exitscript()
{
        #remove lock file
        #rm $lockfile
        exit 0
}

apt-get -y update
sudo apt-get -y install ganglia-monitor

## Set custom hostname and IP
IP=$(ifconfig  | grep 'inet addr:'| grep 168 | grep 192|cut -d: -f2 | awk '{ print $1}')
sed 's/globals {/globals { \n  override_hostname = '$(hostname)' \n  override_ip = '$IP'/' /etc/ganglia/gmond.conf > /tmp/gmond.conf.1

## The current host belong to a cluster : set the name
sed 's/name = "unspecified"/name = "kafka"/' /tmp/gmond.conf.1 > /tmp/gmond.conf.2

## Fix network configuration : main interface eth1 (static)
sed 's/udp_send_channel {/udp_send_channel {\n   mcast_if = eth1/' /tmp/gmond.conf.2 > /tmp/gmond.conf.3
sed 's/udp_recv_channel {/udp_recv_channel {\n   mcast_if = eth1/' /tmp/gmond.conf.3 > /tmp/gmond.conf


mv /etc/ganglia/gmond.conf /etc/ganglia/gmond.conf-bck
cp /tmp/gmond.conf /etc/ganglia/gmond.conf


## Reload configuration
/etc/init.d/ganglia-monitor restart

## Start at boot up
update-rc.d ganglia-monitor defaults

exitscript
