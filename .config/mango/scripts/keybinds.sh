#!/bin/bash
alacritty -e sh -c 'grep -v "^#" ~/.config/mango/bind.conf | grep "^bind=" | sed "s/bind=//" | awk -F, "{printf \"%-25s %s\\n\", \$1\",\"\$2, \$4}" | less'
