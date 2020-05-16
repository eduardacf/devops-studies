#!/bin/bash

today=$(date +%Y_%m_%d__%H_%M_%S);
mkdir -p ./backup/conf/$today
touch env_data.txt
printenv > env_data.txt
mv env_data.txt backup/conf/$today/

