#!/bin/bash

rsync -avz --delete -e 'ssh -p 22222' /home/ictway-yjh/projects/note main@ikaman.duckdns.org:~/coding
