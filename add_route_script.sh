#/bin/bash/

dev=$(ip link show | grep -E -o br-[0-9a-f]{12} | head -n 1)

if [ $(docker ps --filter "name=cassandra_01" --format "{{.Names}}") = "cassandra_01" ]
then
 sudo ip route add 192.168.1.200 dev $(echo $dev)
fi
