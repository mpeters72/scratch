#!/bin/bash

ips=$(cat ips.txt)

for ip in $ips; do
  instance_id=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*][InstanceId]' --filters "Name=ip-address,Values=$ip" --output text)
  if [ -n "$instance_id" ]; then
    name_tag=$(aws ec2 describe-instances --instance-id $instance_id --query 'Reservations[*].Instances[*][Tags][?Key==\'Name\'].Value[0]' --output text)
    echo "Instance ID: $instance_id, Name Tag: $name_tag"
  fi
done
