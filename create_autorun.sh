#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please run with sudo."
    exit 1
fi

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Prompt for task name and command
read -p "Enter a unique task name (e.g., mytask): " task_name
read -p "Enter the command to execute at startup: " command

# Define paths for the script and service
autorun_script="/usr/local/bin/autorun_${task_name}.sh"
service_file="/etc/systemd/system/autorun_${task_name}.service"

# Check if task already exists
if [[ -f "$service_file" ]]; then
    echo -e "${RED}Error: A service with the name 'autorun_${task_name}' already exists.${NC}"
    exit 1
fi

# Create the autorun script
cat <<EOL > "$autorun_script"
#!/bin/bash
# Autorun script for $task_name
$command
EOL

# Make the script executable
chmod +x "$autorun_script"

# Create the systemd service file
cat <<EOL > "$service_file"
[Unit]
Description=Autorun Task: $task_name
After=network.target

[Service]
Type=simple
ExecStart=$autorun_script
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd to apply changes
systemctl daemon-reload

# Enable the service to start on boot
systemctl enable "autorun_${task_name}.service"

# Start the service immediately (optional)
systemctl start "autorun_${task_name}.service"

# Output success message
echo -e "${GREEN}Autorun task '$task_name' created successfully.${NC}"
echo -e "${YELLOW}Script location: $autorun_script${NC}"
echo -e "${YELLOW}Service location: $service_file${NC}"
echo -e "${GREEN}The service has been enabled to run on startup.${NC}"
