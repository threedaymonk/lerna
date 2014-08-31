cat >~/.config/upstart/lerna.conf <<END
description "Lerna multi-head automator"
author "Paul Battley <pbattley@gmail.com>"

# Start and stop with the desktop
start on desktop-start
stop on desktop-end

# Automatically restart process if crashed
respawn

# Logs go to ~/.cache/upstart/lerna.log by default
console log

# Start in foreground mode so it can be properly managed
exec $(pwd)/lerna
END
