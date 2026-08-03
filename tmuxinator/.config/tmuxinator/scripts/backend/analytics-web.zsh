#!/bin/zsh

cd ~/Programming/snapaddy-analytics-web/
pnpm install --config.confirmModulesPurge=false
pnpm build
pnpm run start
