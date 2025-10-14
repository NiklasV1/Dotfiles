#!/bin/zsh

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Set node env or else this crashes
export NODE_ENV=development

cd ~/Programming/snapaddy-rest-api/
nvm use 20
pnpm install --config.confirmModulesPurge=false
pnpm build
pnpm run start
