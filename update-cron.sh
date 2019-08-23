#!/bin/bash

git checkout .
git pull
make clean && make && git add --no-all . && git commit -m "$(date '+%Y-%m-%d') update" && git push
