#!/bin/bash


aws ec2 describe-instances --output table --query "Reservations[*].Instances[*].{Name: Tags[?Key == 'Name'].Value | [0], Id: InstanceId, State: State.Name, Type: InstanceType}" --filters Name=instance-state-name,Values=running

