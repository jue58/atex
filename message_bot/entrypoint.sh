#!/bin/bash

./stars.sh

busybox crond -l 8 -L /dev/stderr -f
