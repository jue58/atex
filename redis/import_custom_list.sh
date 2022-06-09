#!/bin/bash
set -e
sed -z 's/\n/ /g' /custom_list | redis-cli --pipe
