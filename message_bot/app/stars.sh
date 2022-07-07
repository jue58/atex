#!/bin/bash
set -e
cd /app/src
ruby ./star_list_generator.rb /app/custom_list.csv
echo 'Generated star list!'
