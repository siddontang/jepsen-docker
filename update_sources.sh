#!/bin/bash
scp sources.list root@n1:/etc/apt/sources.list
scp sources.list root@n2:/etc/apt/sources.list
scp sources.list root@n3:/etc/apt/sources.list
scp sources.list root@n4:/etc/apt/sources.list
scp sources.list root@n5:/etc/apt/sources.list

ssh root@n1 'apt-get update'
ssh root@n2 'apt-get update'
ssh root@n3 'apt-get update'
ssh root@n4 'apt-get update'
ssh root@n5 'apt-get update'