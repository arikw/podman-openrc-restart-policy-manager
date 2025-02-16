# Podman OpenRC Restart Policy Manager

This OpenRC init script manages the startup and shutdown of Podman containers based on the `restart-policy=always`. It ensures that the containers are started automatically on system boot and stopped on system shutdown, and that they only start once networking is available.

## Features

- Automatically starts Podman containers with `restart-policy=always` on system boot.
- Stops containers on system shutdown.
- Ensures containers start only after the network is up.
- Configurable for different users and Podman setups.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/podman-openrc-restart-policy-manager.git
   cd podman-openrc-restart-policy-manager
   ```

2. Copy the script to the OpenRC init.d directory:
   ```bash
   sudo cp podman-container.sh /etc/init.d/podman-container
   ```

3. Make the script executable:
   ```bash
   sudo chmod +x /etc/init.d/podman-container
   ```

4. Enable the service to start on boot:
   ```bash
   sudo rc-update add podman-container default
   ```

5. Start the service:
   ```bash
   sudo service podman-container start
   ```

## Configuration

The script uses the following configurable variables:

- **`PODMAN`**: The path to the Podman executable.  
  Default: `/usr/bin/podman`  
  To override, set the `PODMAN` environment variable:
  ```bash
  export PODMAN="/usr/local/bin/podman"
  ```

- **`CONTAINER_USER`**: The user under which the Podman containers should run.  
  Default: `root`  
  To override, set the `CONTAINER_USER` environment variable:
  ```bash
  export CONTAINER_USER="youruser"
  ```

These variables can be set globally or within the script itself to customize the behavior based on your environment.

### Example configuration:
To configure the script for a custom Podman path and user, create or modify the `/etc/env.d/99-podman` file:
```bash
PODMAN="/usr/local/bin/podman"
CONTAINER_USER="podmanuser"
```

## Troubleshooting

- If you encounter issues with containers not starting, check the logs with:
   ```bash
   sudo tail -f /var/log/messages
   ```
- Ensure that Podman is installed and the binary path is correct.
