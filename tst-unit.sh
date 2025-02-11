#!/bin/bash

SERVICE_NAME="test"
EXECUTABLE="$(pwd)/$SERVICE_NAME.sh"
UNIT_FILE="/etc/systemd/system/$SERVICE_NAME.service"

cat > $UNIT_FILE <<EOF

[Unit]
Description=Check status available
After=network.target

[Service]
ExecStart=$EXECUTABLE
Restart=always
User=root
WorkingDirectory=/
TimeoutSec=10

[Install]
WantedBy=multi-user.target

EOF

sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME
sudo systemctl restart $SERVICE_NAME

echo "Running $SERVICE_NAME"
