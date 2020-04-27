#!/bin/bash

echo "ᐰ"
vncserver -geometry $VNC_RESOLUTION -depth $VNC_COL_DEPTH :1
tail -f /root/.vnc/*.log