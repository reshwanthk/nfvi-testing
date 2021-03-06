#!/bin/bash

client_svc="http-client"
client_pod="http-client"

svc_node_port=$(oc describe service $client_svc|awk '/^NodePort/{print $3}'|cut -d'/' -f1)
pod_host=$(oc get pods -o wide|awk '/^http-client/{print $7}')

echo "Fetching autoscale-client(http-client) external IP/port(NodePort IP/port)"
echo
echo "Host: $pod_host"
echo "Port: $svc_node_port"

curl http://$pod_host:$svc_node_port/

[ $? == 0 ] && echo "Successfully tested connection to server app"
echo
echo "Update Host and Port in autoscale-testing.py script"
