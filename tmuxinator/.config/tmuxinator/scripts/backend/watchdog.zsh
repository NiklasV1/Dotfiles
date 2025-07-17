#!/bin/zsh

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

cd ~/Programming/snapaddy-watchdog/
nvm use 18
pnpm install --config.confirmModulesPurge=false
pnpm run build
pnpm run start
