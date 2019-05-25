#!/bin/sh

USER='hogehoge'
IP_ADDRESS='XX.XX.XX.XX'
USER_PASS1='p@ssword' # password for USER
PORT_NUMBER='22'
KEY_PATH='/Users/hogehoge/.ssh/key' # Location of USER's key 

expect -c "
set timeout 1
spawn ssh ${USER}@${IP_ADDRESS} -p ${PORT_NUMBER} -i ${KEY_PATH}
expect \"]\$ \"
send \"sudo su -\n\"
#expect \"パスワード: \"
#send \"${USER_PASS1}\n\"
interact
"
