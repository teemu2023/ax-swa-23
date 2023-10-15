#!/bin/bash

expected_command="curl -v localhost:32100/auctions/12345/bids"

student_command=$(cat /root/answer1.txt)

if [ "$student_command" == "$expected_command" ]; then
    echo "Task completed successfully"
    exit 0
else
    echo "Task not completed. Please try again."
    exit 1
fi