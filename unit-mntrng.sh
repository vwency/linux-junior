#!/bin/bash

SERVICE_NAME="check-available"
EXECUTABLE="$(pwd)/$SERVICE_NAME.sh"
UNIT_FILE="/etc/systemd/system/$SERVICE_NAME.service"
LOG_FILE="/var/log/monitoring.log"

cat > $UNIT_FILE <<EOF

[Unit]
Description=Check status available
After=network.target

[Service]
ExecStartPre=/usr/bin/touch $LOG_FILE
ExecStart=$EXECUTABLE
Restart=always
User=root
WorkingDirectory=/
StandardOutput=append:/var/log/monitoring.log
StandardError=append:/var/log/monitoring.log
TimeoutSec=300

[Install]
WantedBy=multi-user.target

EOF

sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME
sudo systemctl restart $SERVICE_NAME

echo "Running $SERVICE_NAME"
