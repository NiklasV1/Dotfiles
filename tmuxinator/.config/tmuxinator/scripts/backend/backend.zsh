#!/bin/zsh

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

cd ~/Programming/snapaddy-backend/
nvm use 18
rush build
rush start:feat
