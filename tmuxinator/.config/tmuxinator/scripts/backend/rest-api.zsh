#!/bin/zsh

# Set node env or else this crashes
export NODE_ENV=development

cd ~/Programming/snapaddy-rest-api/
pnpm install --config.confirmModulesPurge=false
pnpm build
pnpm run start
