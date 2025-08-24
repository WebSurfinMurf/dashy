#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== One-Time Keycloak Setup for Dashy ===${NC}"
echo ""
echo "This script guides you through the initial Keycloak configuration."
echo ""

# Check if environment file exists
ENV_FILE="/home/administrator/projects/secrets/dashy.env"
if [ -f "$ENV_FILE" ]; then
    echo -e "${YELLOW}Environment file already exists. Checking configuration...${NC}"
    source "$ENV_FILE"
    if [ "$OAUTH2_PROXY_CLIENT_SECRET" != "PLACEHOLDER" ] && [ -n "$OAUTH2_PROXY_CLIENT_SECRET" ]; then
        echo -e "${GREEN}✓ Keycloak appears to be already configured${NC}"
        echo "Client Secret is set. If you need to reconfigure, edit $ENV_FILE"
        exit 0
    fi
else
    echo -e "${YELLOW}Creating environment file...${NC}"
    
    # Generate cookie secret
    COOKIE_SECRET=$(openssl rand -base64 32 | tr -- '+/' '-_')
    
    cat > "$ENV_FILE" << EOF
# Dashy OAuth2 Proxy Environment Configuration
# Generated: $(date +%Y-%m-%d)

# OAuth2 Proxy Configuration
OAUTH2_PROXY_CLIENT_ID=dashy
OAUTH2_PROXY_CLIENT_SECRET=PLACEHOLDER
OAUTH2_PROXY_COOKIE_SECRET=${COOKIE_SECRET}
OAUTH2_PROXY_PROVIDER=keycloak-oidc
OAUTH2_PROXY_OIDC_ISSUER_URL=https://keycloak.ai-servicers.com/realms/master

# Skip OIDC discovery and use internal URLs for token validation
OAUTH2_PROXY_SKIP_OIDC_DISCOVERY=true
OAUTH2_PROXY_OIDC_JWKS_URL=http://keycloak:8080/realms/master/protocol/openid-connect/certs
OAUTH2_PROXY_LOGIN_URL=https://keycloak.ai-servicers.com/realms/master/protocol/openid-connect/auth
OAUTH2_PROXY_REDEEM_URL=http://keycloak:8080/realms/master/protocol/openid-connect/token

# OAuth2 settings
OAUTH2_PROXY_REDIRECT_URL=https://dashy.ai-servicers.com/oauth2/callback
OAUTH2_PROXY_EMAIL_DOMAINS=*
OAUTH2_PROXY_COOKIE_SECURE=true
OAUTH2_PROXY_HTTP_ADDRESS=0.0.0.0:4180
OAUTH2_PROXY_SKIP_PROVIDER_BUTTON=true
OAUTH2_PROXY_PASS_USER_HEADERS=true
OAUTH2_PROXY_SET_XAUTHREQUEST=true
OAUTH2_PROXY_SET_AUTHORIZATION_HEADER=true
OAUTH2_PROXY_PROXY_PREFIX=/oauth2

# Restrict to administrators group (uncomment to enable)
# OAUTH2_PROXY_ALLOWED_GROUPS=/administrators

# Dashy Configuration
NODE_ENV=production
EOF
    
    chmod 600 "$ENV_FILE"
    echo -e "${GREEN}✓ Environment file created${NC}"
fi

echo ""
echo -e "${BLUE}=== Step 1: Create Keycloak Client ===${NC}"
echo ""
echo "1. Open Keycloak Admin Console:"
echo "   ${GREEN}https://keycloak.ai-servicers.com/admin${NC}"
echo ""
echo "2. Navigate to: Clients → Create client"
echo ""
echo "3. Configure General Settings:"
echo "   - Client type: ${YELLOW}OpenID Connect${NC}"
echo "   - Client ID: ${YELLOW}dashy${NC}"
echo "   - Name: ${YELLOW}Dashy Dashboard${NC}"
echo "   - Click 'Next'"
echo ""
echo "4. Configure Capability Config:"
echo "   - Client authentication: ${YELLOW}ON${NC}"
echo "   - Authorization: ${YELLOW}OFF${NC}"
echo "   - Click 'Next'"
echo ""
echo "5. Configure Login Settings:"
echo "   - Root URL: ${YELLOW}https://dashy.ai-servicers.com${NC}"
echo "   - Valid redirect URIs: ${YELLOW}https://dashy.ai-servicers.com/*${NC}"
echo "   - Click 'Save'"
echo ""

echo -e "${BLUE}=== Step 2: Get Client Secret ===${NC}"
echo ""
echo "1. Click on the 'dashy' client you just created"
echo "2. Go to the ${YELLOW}Credentials${NC} tab"
echo "3. Copy the ${YELLOW}Client secret${NC}"
echo ""
read -p "Enter the client secret from Keycloak: " CLIENT_SECRET

if [ -z "$CLIENT_SECRET" ]; then
    echo -e "${RED}No secret provided. Exiting.${NC}"
    exit 1
fi

# Update the environment file with the secret
sed -i "s/OAUTH2_PROXY_CLIENT_SECRET=PLACEHOLDER/OAUTH2_PROXY_CLIENT_SECRET=$CLIENT_SECRET/" "$ENV_FILE"
echo -e "${GREEN}✓ Client secret saved${NC}"

echo ""
echo -e "${BLUE}=== Step 3: Configure Group Mapper ===${NC}"
echo ""
echo "1. In the dashy client, go to ${YELLOW}Client scopes${NC} tab"
echo "2. Click on ${YELLOW}dashy-dedicated${NC}"
echo "3. Go to ${YELLOW}Mappers${NC} tab"
echo "4. Click ${YELLOW}Add mapper${NC} → ${YELLOW}By configuration${NC} → ${YELLOW}Group Membership${NC}"
echo "5. Configure:"
echo "   - Name: ${YELLOW}groups${NC}"
echo "   - Token Claim Name: ${YELLOW}groups${NC}"
echo "   - Full group path: ${YELLOW}ON${NC}"
echo "   - Add to ID token: ${YELLOW}ON${NC}"
echo "   - Add to access token: ${YELLOW}ON${NC}"
echo "   - Add to userinfo: ${YELLOW}ON${NC}"
echo "6. Click ${YELLOW}Save${NC}"
echo ""
read -p "Press Enter when you've completed the group mapper configuration..."

echo ""
echo -e "${BLUE}=== Step 4: Create Administrators Group ===${NC}"
echo ""
echo "1. Navigate to: Groups → Create group"
echo "2. Name: ${YELLOW}administrators${NC}"
echo "3. Click ${YELLOW}Create${NC}"
echo ""
echo "4. Add yourself to the group:"
echo "   - Go to Users → View all users"
echo "   - Click on your username"
echo "   - Go to ${YELLOW}Groups${NC} tab"
echo "   - Click ${YELLOW}Join Group${NC}"
echo "   - Select ${YELLOW}administrators${NC}"
echo "   - Click ${YELLOW}Join${NC}"
echo ""
read -p "Press Enter when you've added yourself to the administrators group..."

echo ""
echo -e "${GREEN}=== Setup Complete ===${NC}"
echo ""
echo "Configuration saved to: $ENV_FILE"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Run: ${GREEN}./deploy.sh${NC} to deploy Dashy with authentication"
echo "2. Logout from Keycloak to get a fresh session with groups"
echo "3. Access Dashy at: ${GREEN}https://dashy.ai-servicers.com${NC}"
echo ""
echo -e "${YELLOW}To enable group restriction (administrators only):${NC}"
echo "Uncomment the OAUTH2_PROXY_ALLOWED_GROUPS line in $ENV_FILE"
echo "Then run ./deploy.sh again"