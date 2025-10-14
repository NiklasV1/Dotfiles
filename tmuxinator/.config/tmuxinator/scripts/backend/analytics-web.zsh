#!/bin/zsh

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

cd ~/Programming/snapaddy-analytics-web/
nvm use 20
pnpm install --config.confirmModulesPurge=false
pnpm build
pnpm run start
