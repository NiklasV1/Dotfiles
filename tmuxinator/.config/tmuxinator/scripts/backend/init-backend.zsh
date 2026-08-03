#!/bin/zsh

# Login to AWS if needed
aws sts get-caller-identity --no-cli-pager
AWS_EXIT_CODE="$?"
if [ "$AWS_EXIT_CODE" -ne 0 ]; then
  aws sso login
fi

# Start local DB
make db/start

# Select branch
lazygit
