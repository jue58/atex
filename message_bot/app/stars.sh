#!/bin/bash
set -e
cd /app/src
ruby ./star_list_generator.rb
echo 'Generated star list!'
