#!/bin/bash

# Podman Network Management Script
# This script defines and maintains the core network topology for the container environment.

# 1. net-edge: For front-facing services (Nginx, Traefik, Proxies). 
#    - Allows external access.
#    - Shared across all frontend components.
podman network exists net-edge || podman network create \
    --driver bridge \
    --label "usage=frontend" \
    --label "security=edge" \
    net-edge

# 2. net-app-shared: For shared internal services (Redis, Auth, Logging).
#    - Internal communication between apps and infra.
podman network exists net-infra || podman network create \
    --driver bridge \
    --label "usage=shared-resources" \
    net-infra

# 3. net-isolated: Strictly internal. No Internet access.
#    - Good for Databases and sensitive processing.
#    - We use --internal flag to prevent outbound traffic.
podman network exists net-db-private || podman network create \
    --driver bridge \
    --internal \
    --label "security=isolated" \
    net-db-private

# 4. net-management: For cross-node cluster clusters or management tools.
podman network exists net-mgmt || podman network create \
    --driver bridge \
    net-mgmt

echo "Successfully synchronized network topology."
podman network ls --filter "label=usage" --filter "label=security"
