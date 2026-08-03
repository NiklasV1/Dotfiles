#!/bin/zsh

cd ~/Programming/snapaddy-backend/
lazygit
rush install
rush build-only
rush start:partial
