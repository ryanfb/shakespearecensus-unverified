#!/bin/bash

git checkout .
git pull
make clean
make
git add .
git commit -m "$(date '+%Y-%m-%d') update"
git push
