#!/bin/zsh

cd ~/Programming/snapaddy-watchdog/
pnpm install --config.confirmModulesPurge=false
pnpm run build
pnpm run start
