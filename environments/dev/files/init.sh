#!/bin/bash

exec > >(tee -a /var/log/user-data.log) 2>&1
echo "[$(date)] Starting custom init script"

# # Wait for cloud-init to complete
# echo "[$(date)] Waiting for cloud-init..."
# cloud-init status --wait

# Update package list
echo "[$(date)] Updating package list..."
apt-get update -y

# Install necessary packages
echo "[$(date)] Installing prerequisites..."
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg \
    lsb-release

# Add Docker's official GPG key
echo "[$(date)] Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "[$(date)] Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again after adding Docker repository
echo "[$(date)] Updating package list with Docker repository..."
apt-get update -y

# Install Docker
echo "[$(date)] Installing Docker..."
DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
echo "[$(date)] Starting Docker service..."
systemctl start docker
systemctl enable docker

# Install Docker Compose
echo "[$(date)] Installing Docker Compose..."
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d '"' -f 4)
curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Add current user to docker group
echo "[$(date)] Configuring user permissions..."
usermod -aG docker azureuser

# Print versions for verification
echo "[$(date)] Installation complete. Versions:"
docker --version
docker-compose --version

docker run -d \
  --name db \
  -p 5432:5432 \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=pass \
  -e POSTGRES_DB=demo \
  --health-cmd="pg_isready -U postgres" \
  --health-interval=5s \
  --health-timeout=5s \
  --health-retries=5 \
  postgres

sleep 15

docker run -d \
  --name soul-animal-app \
  -p 80:8000 \
  -e DATABASE_URL=postgresql://postgres:pass@172.17.0.1/demo \
  -e INIT_DB=true \
  n0x41yeem/soul-animal:latest
echo "[$(date)] Custom init script completed"