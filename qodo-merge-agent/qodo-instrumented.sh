#!/bin/bash

touch /tmp/qodo-tcpdump.pcap

tcpdump -i any -w /tmp/qodo-tcpdump.pcap -s 0 -U &

python3 pr_agent/cli.py "$@"
