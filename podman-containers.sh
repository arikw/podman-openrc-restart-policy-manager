#!/sbin/openrc-run

description="Podman Containers Service"

# Default values for configurable variables
DEFAULT_PODMAN="/usr/bin/podman"
DEFAULT_CONTAINER_USER="root"  # You can change this to a specific user for running the containers

# Allow user to override defaults
PODMAN="${PODMAN:-$DEFAULT_PODMAN}"
CONTAINER_USER="${CONTAINER_USER:-$DEFAULT_CONTAINER_USER}"

command="$PODMAN"
command_args="start --all --filter restart-policy=always"
name="podman-containers"

depend() {
  # Ensure containers start after the network is up
  need net  # Ensures that the network is up before starting the containers
}

start() {
  ebegin "Starting Podman containers with restart policy"
  sudo -u "$CONTAINER_USER" "$PODMAN" start --all --filter restart-policy=always
  eend $?
}

stop() {
  ebegin "Stopping Podman containers with restart policy"
  
  CONTAINERS=$(sudo -u "$CONTAINER_USER" "$PODMAN" container ls --filter restart-policy=always -q)
  
  if [ -n "$CONTAINERS" ]; then
    for CONTAINER in $CONTAINERS; do
      sudo -u "$CONTAINER_USER" "$PODMAN" stop "$CONTAINER"
    done
    eend $?
  else
    eend 0
    echo "No containers with restart policy=always are running."
  fi
}
