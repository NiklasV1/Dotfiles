#!/bin/zsh

cd ~/Programming/snapaddy-web/
pnpm install --config.confirmModulesPurge=false
pnpm build
pnpm run start
