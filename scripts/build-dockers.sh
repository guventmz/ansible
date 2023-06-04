#!/usr/bin/env bash

docker build . -f new-computer.Dockerfile -t new-computer
docker build . -f nvim.Dockerfile -t nvim-computer
