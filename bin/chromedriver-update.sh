#!/bin/bash
set -ueo pipefail

echo "> brew update..."
brew update

echo "> brew upgrade chromedriver..."
brew upgrade chromedriver

echo "> spctl --add --label 'Approved' \"$(brew --prefix)/bin/chromedriver\""
echo "NOTE: This is going to prompt you to put in the system password"
spctl --add --label 'Approved' "$(brew --prefix)/bin/chromedriver"
