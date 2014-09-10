# Personal Config

Because it's always different on every single machine I use.

## Installation

    git clone git@github.com:tomdalling/config.git ~/config
    cd ~/config
    git submodule init
    git submodule update
    ./install.sh

## Adding Vim Plugin Submodules

Use the https github urls, so the repos can be cloned without credentials.

    cd ~/config/vim/bundle
    git submodule add https://github.com/tpope/vim-rails.git

