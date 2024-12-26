# Multi-Autorun Bash Script

This repository contains a Bash script to set up **multiple autorun tasks** for your machine or VPS (outside of Docker). Each task is managed using a unique `systemd` service, enabling custom commands or scripts to be executed automatically on system startup.

## Features

- **Multiple Autorun Configurations**: Create as many autorun tasks as needed, each with its own unique configuration.
- **Systemd Integration**: Leverages `systemd` for reliable startup execution and failure recovery.
- **Custom Commands**: Allows you to specify any command or script to run on startup.
- **Ease of Use**: Simple prompts for task name and command, with automatic setup and management.

---

## How It Works

1. **Prompts for Input**:
   - A unique task name (e.g., `mytask`) to identify the script and service.
   - A custom command or script to execute on startup.

2. **Generates an Autorun Script**:
   - Creates a Bash script (`/usr/local/bin/autorun_<task_name>.sh`) for the specific task.

3. **Creates a Systemd Service**:
   - Sets up a `systemd` service (`/etc/systemd/system/autorun_<task_name>.service`) to manage the autorun task.

4. **Enables and Starts the Service**:
   - The service is enabled to run on system startup and can also be started immediately.

---

## Installation

Download and run the script directly:
   ```bash
   curl -o create_autorun.sh https://raw.githubusercontent.com/juliwicks/autorun-command-linux/refs/heads/main/create_autorun.sh && chmod +x create_autorun.sh && sudo ./create_autorun.sh

