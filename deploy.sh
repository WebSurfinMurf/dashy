#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== Dashy Dashboard Deployment with Keycloak OAuth2 ===${NC}"

# Check if running as administrator user
if [[ $EUID -eq 0 ]]; then
   echo -e "${RED}This script should not be run as root!${NC}"
   exit 1
fi

# Load environment variables
if [ ! -f /home/administrator/projects/secrets/dashy.env ]; then
    echo -e "${RED}Environment file not found: /home/administrator/projects/secrets/dashy.env${NC}"
    echo "Run ./setup-keycloak.sh first to configure Keycloak integration"
    exit 1
fi

source /home/administrator/projects/secrets/dashy.env

# Verify required variables
if [ "$OAUTH2_PROXY_CLIENT_SECRET" = "PLACEHOLDER" ] || [ -z "$OAUTH2_PROXY_CLIENT_SECRET" ]; then
    echo -e "${RED}CLIENT_SECRET not configured in /home/administrator/projects/secrets/dashy.env${NC}"
    echo "Get the secret from Keycloak admin → Clients → dashy → Credentials"
    exit 1
fi

# Stop and remove existing containers
echo -e "${YELLOW}Stopping existing Dashy containers...${NC}"
docker kill dashy 2>/dev/null || true
docker rm dashy 2>/dev/null || true
docker kill dashy-auth-proxy 2>/dev/null || true
docker rm dashy-auth-proxy 2>/dev/null || true

# Verify containers are stopped
if docker ps | grep -q "dashy\|dashy-auth-proxy"; then
    echo -e "${RED}Failed to stop containers. Please stop them manually.${NC}"
    exit 1
fi

# Create network if it doesn't exist
echo -e "${YELLOW}Ensuring network exists...${NC}"
docker network create traefik-net 2>/dev/null || echo "Network traefik-net already exists"

# Deploy Dashy container (internal only, no Traefik labels)
echo -e "${YELLOW}Deploying Dashy container...${NC}"
docker run -d \
  --name dashy \
  --restart unless-stopped \
  --network traefik-net \
  -v /home/administrator/projects/dashy/config/conf.yml:/app/user-data/conf.yml \
  -v /home/administrator/projects/dashy/data:/app/user-data \
  --health-cmd "node /app/services/healthcheck || exit 1" \
  --health-interval 30s \
  --health-timeout 10s \
  --health-retries 3 \
  lissy93/dashy:latest

# Ensure dashy is resolvable by name on the network
echo -e "${YELLOW}Configuring network alias...${NC}"
docker network disconnect traefik-net dashy 2>/dev/null || true
docker network connect --alias dashy traefik-net dashy

# Deploy OAuth2 Proxy with Traefik labels
echo -e "${YELLOW}Deploying OAuth2 Proxy...${NC}"
docker run -d \
  --name dashy-auth-proxy \
  --restart unless-stopped \
  --network traefik-net \
  --env-file /home/administrator/projects/secrets/dashy.env \
  -e OAUTH2_PROXY_UPSTREAMS=http://dashy:8080/ \
  -e OAUTH2_PROXY_PASS_HOST_HEADER=false \
  --label "traefik.enable=true" \
  --label "traefik.docker.network=traefik-net" \
  --label "traefik.http.routers.dashy.rule=Host(\`dashy.ai-servicers.com\`)" \
  --label "traefik.http.routers.dashy.entrypoints=websecure" \
  --label "traefik.http.routers.dashy.tls=true" \
  --label "traefik.http.routers.dashy.tls.certresolver=letsencrypt" \
  --label "traefik.http.services.dashy.loadbalancer.server.port=4180" \
  quay.io/oauth2-proxy/oauth2-proxy:latest

# Connect OAuth2 proxy to additional networks
echo -e "${YELLOW}Connecting OAuth2 proxy to keycloak-net...${NC}"
docker network create keycloak-net 2>/dev/null || echo "Network keycloak-net already exists"
docker network connect keycloak-net dashy-auth-proxy 2>/dev/null || true

echo -e "${YELLOW}Waiting for containers to start...${NC}"
sleep 10

# Check container status
echo -e "${YELLOW}Container status:${NC}"
docker ps | grep dashy | awk '{print $NF, $7, $8, $9}'

# Wait for Dashy to become healthy
echo -e "${YELLOW}Waiting for Dashy to become healthy (up to 60 seconds)...${NC}"
for i in {1..12}; do
    if docker ps | grep dashy | grep -q "healthy"; then
        echo -e "${GREEN}Dashy is healthy!${NC}"
        break
    fi
    echo -n "."
    sleep 5
done
echo ""

# Test internal connectivity
echo -e "${YELLOW}Testing internal connectivity...${NC}"
if docker run --rm --network traefik-net alpine ping -c 1 dashy >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Network alias working${NC}"
else
    echo -e "${RED}✗ Network alias not working${NC}"
fi

echo ""
echo -e "${GREEN}=== Deployment Complete ===${NC}"
echo ""
echo -e "${GREEN}Access Dashy at:${NC} https://dashy.ai-servicers.com"
echo ""
echo -e "${YELLOW}Useful commands:${NC}"
echo "  Check logs:    docker logs dashy-auth-proxy --tail 20"
echo "  Check session: https://dashy.ai-servicers.com/oauth2/userinfo"
echo "  Restart auth:  docker restart dashy-auth-proxy"
echo ""

# Check if group restriction is enabled
if grep -q "^OAUTH2_PROXY_ALLOWED_GROUPS=" /home/administrator/projects/secrets/dashy.env; then
    echo -e "${GREEN}Group restriction: ENABLED (administrators only)${NC}"
else
    echo -e "${YELLOW}Group restriction: DISABLED (all authenticated users)${NC}"
    echo "To enable: Uncomment OAUTH2_PROXY_ALLOWED_GROUPS in dashy.env"
fi