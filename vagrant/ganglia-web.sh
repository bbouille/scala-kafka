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

## Install RRDTool and a web server
apt-get -y install rrdtool libapache2-mod-php5 php5 php5-gd php5-rrd

## Setup ganglia-web configuration
cd /tmp/
wget http://sourceforge.net/projects/ganglia/files/ganglia-web/3.5.12/ganglia-web-3.5.12.tar.gz
tar xf ganglia-web-3.5.12.tar.gz
mv ganglia-web-3.5.12 /var/www/ganglia

## Create working folders
mkdir -p /var/lib/ganglia-web/dwoo/cache
mkdir -p /var/lib/ganglia-web/dwoo/compiled
mkdir -p /var/lib/ganglia-web/conf

## Set priviledges
chown -R www-data:www-data /var/www/ganglia
chown -R www-data:www-data /var/lib/ganglia-web

/etc/init.d/apache2 restart

exitscript
