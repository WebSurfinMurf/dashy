# Dashy Dashboard with Keycloak OAuth2 - Lessons Learned

## Working Configuration
**Date**: 2025-08-24  
**Status**: ✅ WORKING - Dashy protected by Keycloak OAuth2 authentication  
**Last Updated**: 2025-09-01

## Recent Configuration Updates

### 2025-09-02 Changes (00:42 UTC)
- **Updated Logging & Monitoring section order** per user request:
  1. Dozzle (first) - Real-time container log viewer
  2. Grafana (second) - Metrics and logs visualization dashboard 
  3. Loki (third) - Log aggregation system with web UI
  4. Netdata (fourth) - Real-time system metrics and monitoring
- **Added Grafana** to the Logging & Monitoring section (was not included before)
- **Rebuilt and restarted Dashy** to apply configuration changes

### 2025-09-01 Changes (18:43 UTC)
- **Reorganized sections** in new order: AI Tools, Development Tools, Security, External Services, Core Services, Data & Integration Tools, Infrastructure Management, Logging & Monitoring, Architecture & Design
- **Added new Logging & Monitoring section** with three observability services:
  - Loki - Log aggregation system with web UI (Keycloak SSO)
  - Netdata - Real-time system metrics and monitoring (Keycloak SSO)
  - Dozzle - Real-time container log viewer (Keycloak SSO)
- **Rebuilt Dashy** to apply configuration changes

### 2025-09-01 Changes (Earlier)
- **Added OpenProject** to Core Services - Project management platform
- **Added MinIO** to Data & Integration Tools - S3-compatible object storage
- **Reordered Core Services** for better workflow: Guacamole, OpenProject, Web Portal, Nextcloud
- **Rebuilt and restarted** Dashy to apply all changes

### 2025-08-28 Changes
- **Moved Guacamole** from Development Tools to Core Services
- **Removed Rundeck** - Job automation platform (no longer needed)
- **Updated pgAdmin URL** to external https://pgadmin.ai-servicers.com with SSO
- **Added AWS Console** to External Services section
- **Verified** all services are operational and properly categorized

## Access URLs
- **Dashboard**: https://dashy.ai-servicers.com
- **Session Info**: https://dashy.ai-servicers.com/oauth2/userinfo
- **Test Page**: https://nginx.ai-servicers.com/session-test.html

## Architecture
```
Internet → Traefik → OAuth2 Proxy (port 4180) → Dashy (port 8080)
                           ↓
                       Keycloak
```

## Critical Lessons Learned

### 1. Container Health State Issue
**Problem**: Dashy container stuck in "starting" state, never became healthy  
**Cause**: Default health check interval was 5 minutes (300 seconds)  
**Solution**: Add custom health check with 30-second interval
```bash
--health-cmd "node /app/services/healthcheck || exit 1" \
--health-interval 30s \
--health-timeout 10s \
--health-retries 3
```

### 2. Container Name Resolution
**Problem**: OAuth2 proxy couldn't resolve "dashy" hostname, returned 404  
**Cause**: Docker container name not automatically resolvable on network  
**Solution**: Add network alias when connecting container
```bash
docker network disconnect traefik-proxy dashy 2>/dev/null || true
docker network connect --alias dashy traefik-proxy dashy
```

### 3. OAuth2 Proxy Upstream Configuration
**Problem**: OAuth2 proxy returned 404 even when authenticated  
**Key Findings**:
- Must use `OAUTH2_PROXY_UPSTREAMS` (plural) not `OAUTH2_PROXY_UPSTREAM`
- Must include trailing slash: `http://dashy:8080/`
- Set `OAUTH2_PROXY_PASS_HOST_HEADER=false` for internal services

### 4. Keycloak Group Mapping
**Problem**: User groups not included in OAuth2 token  
**Solution**: Add group mapper in Keycloak
1. Go to Clients → dashy → Client scopes → dashy-dedicated
2. Add mapper → By configuration → Group Membership
3. Configure:
   - Name: `groups`
   - Token Claim Name: `groups`
   - Full group path: ON (for /administrators)
   - Add to ID token: ON
   - Add to access token: ON
   - Add to userinfo: ON

### 5. Session Caching
**Problem**: Old session persisted even after Keycloak changes  
**Solution**: 
- Force logout from Keycloak
- Clear browser cookies for both domains
- Use incognito window for testing
- Restart OAuth2 proxy container to clear server-side cache

### 6. Port Configuration
**Clarification**: 
- Container-internal ports (8080) don't conflict with other containers
- Only host-exposed ports need to be unique
- Dashy uses port 8080 internally by default - don't change it

### 7. Debug Logging
**Essential for troubleshooting OAuth2 Proxy**:
```bash
-e OAUTH2_PROXY_LOGGING_LEVEL=debug \
-e OAUTH2_PROXY_STANDARD_LOGGING=true \
-e OAUTH2_PROXY_REQUEST_LOGGING=true \
-e OAUTH2_PROXY_AUTH_LOGGING=true
```

## Environment Variables Required
```bash
# OAuth2 Proxy Configuration
OAUTH2_PROXY_CLIENT_ID=dashy
OAUTH2_PROXY_CLIENT_SECRET=<from-keycloak>
OAUTH2_PROXY_COOKIE_SECRET=<generated>
OAUTH2_PROXY_PROVIDER=keycloak-oidc
OAUTH2_PROXY_OIDC_ISSUER_URL=https://keycloak.ai-servicers.com/realms/master
OAUTH2_PROXY_REDIRECT_URL=https://dashy.ai-servicers.com/oauth2/callback
OAUTH2_PROXY_EMAIL_DOMAINS=*
OAUTH2_PROXY_COOKIE_SECURE=true
OAUTH2_PROXY_UPSTREAMS=http://dashy:8080/  # Note: UPSTREAMS (plural) with trailing slash
OAUTH2_PROXY_PASS_HOST_HEADER=false
OAUTH2_PROXY_HTTP_ADDRESS=0.0.0.0:4180
# Optional: Restrict to administrators group
# OAUTH2_PROXY_ALLOWED_GROUPS=/administrators
```

## Keycloak Client Configuration
- **Client ID**: dashy
- **Client Type**: OpenID Connect
- **Access Type**: Confidential
- **Valid Redirect URIs**: https://dashy.ai-servicers.com/*
- **Group Mapper**: Required for group-based access control

## Network Requirements
- Both containers must be on `traefik-proxy` network
- Dashy must have network alias for name resolution
- OAuth2 Proxy needs Traefik labels (not Dashy)

## Common Pitfalls to Avoid
1. ❌ Don't try to force Dashy to use different internal port
2. ❌ Don't put Traefik labels on Dashy when using OAuth2 proxy
3. ❌ Don't use localhost or 127.0.0.1 for container-to-container communication
4. ❌ Don't forget the trailing slash in UPSTREAMS URL
5. ❌ Don't assume container names resolve without network alias
6. ❌ Don't skip the group mapper configuration in Keycloak

## Testing Commands
```bash
# Check if Dashy is healthy
docker ps | grep dashy

# Test Dashy from internal network
docker run --rm --network traefik-proxy alpine sh -c "ping -c 1 dashy"
docker run --rm --network traefik-proxy curlimages/curl curl -I http://dashy:8080

# Check OAuth2 Proxy logs
docker logs dashy-auth-proxy --tail 20

# Force restart to clear cache
docker restart dashy-auth-proxy
```

## Files Structure
```
/home/administrator/projects/dashy/
├── config/
│   └── conf.yml           # Dashy configuration
├── data/                  # Dashy persistent data
├── deploy.sh             # Main deployment script
├── setup-keycloak.sh     # One-time Keycloak setup
└── CLAUDE.md             # This documentation
```

## Recovery Procedure
If Dashy stops working:
1. Check container health: `docker ps | grep dashy`
2. Check logs: `docker logs dashy-auth-proxy --tail 50`
3. Verify network alias: `docker exec dashy hostname`
4. Test internal connectivity: `docker run --rm --network traefik-proxy alpine ping -c 1 dashy`
5. Clear session and retry in incognito mode
6. If stuck, kill containers properly before restarting:
   ```bash
   docker kill dashy dashy-auth-proxy
   docker rm dashy dashy-auth-proxy
   ./deploy.sh
   ```

## Scanning for New Applications

When discovering and adding new services to Dashy, follow this procedure:

### 1. Discovery Commands
```bash
# List all running Docker containers
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Check projects directory for deployed services
ls -la /home/administrator/projects/

# Check for services with web interfaces
docker ps --format "{{.Names}}" | while read container; do
  docker inspect $container | grep -E "VIRTUAL_HOST|traefik.http.routers" | head -5
done

# Check Docker networks for service groupings
docker network ls
```

### 2. Categorization Guidelines
Follow the structure defined in `DASHY-ORGANIZATION.md`:
- **Core Services**: Essential platforms (Nextcloud, Web Portal)
- **Development Tools**: Coding and remote access (Guacamole, GitHub, Claude Code)
- **Infrastructure Management**: Admin tools (Portainer, Traefik, Keycloak)
- **Data & Integration Tools**: Databases and management UIs
- **AI Tools**: LLMs and AI assistants
- **Architecture & Design**: Diagramming tools
- **Email Services**: Webmail and email admin
- **External Services**: Third-party SaaS

### 3. Service Information to Collect
For each discovered service:
- Container name and status
- Access URL (internal vs external)
- Authentication method (SSO, basic auth, open)
- Network placement
- Icon source (Dashboard Icons CDN preferred)
- Appropriate tags

### 4. Update Process
1. Backup configuration: `cp config/conf.yml config/conf.yml.backup.$(date +%Y%m%d_%H%M%S)`
2. Edit `config/conf.yml` following the categorization
3. Update `DASHY-ORGANIZATION.md` with new service status
4. Update `SERVICES-INVENTORY.yml` for tracking
5. **IMPORTANT**: Rebuild Dashy to apply changes:
   ```bash
   # Option 1: Rebuild inside container (faster)
   docker exec dashy yarn build
   
   # Option 2: Restart container (also triggers rebuild)
   docker restart dashy
   ```
6. Wait ~30 seconds for build to complete
7. Clear browser cache (Shift+Refresh) 
8. Verify at https://dashy.ai-servicers.com

**Note**: Dashy reads config at build-time, not runtime. Changes require rebuild!

### 5. Service Status Legend
- ✅ **In Dashy**: Fully configured and accessible
- 🚀 **Deployed**: Running but not added to Dashy
- 📋 **Planned**: Not yet deployed

## Current Service Status (2025-09-01) - New Organization

### 1. AI Tools
- ✅ OpenWebUI - Local LLM interface
- ✅ ChatGPT - OpenAI assistant

### 2. Development Tools  
- ✅ GitLab - Git repository and CI/CD
- ✅ GitHub - External code repositories

### 3. Security
- ✅ Keycloak Admin - Identity management
- ✅ OAuth2 Session Info - Current session
- ✅ Keycloak Logout - Single sign-out

### 4. External Services
- ✅ Cloudflare - DNS & CDN
- ✅ SendGrid - Email delivery
- ✅ AWS Console - Amazon Web Services

### 5. Core Services
- ✅ Guacamole - Remote access gateway with SSO
- ✅ OpenProject - Project management platform
- ✅ Web Portal - Main landing page
- ✅ Nextcloud - File sharing platform

### 6. Data & Integration Tools
- ✅ pgAdmin - PostgreSQL management (external URL with SSO)
- ✅ Redis Commander - Redis management
- ✅ MongoDB Express - MongoDB management
- ✅ MinIO - S3-compatible object storage

### 7. Infrastructure Management
- ✅ Portainer - Docker management with SSO
- ✅ Traefik - Reverse proxy (internal access)
- ✅ Postfixadmin - Email admin (internal only)

### 8. Logging & Monitoring (NEW SECTION)
- ✅ Dozzle - Real-time container log viewer (Keycloak SSO) - **FIRST**
- ✅ Grafana - Metrics and logs visualization dashboard (Keycloak SSO) - **SECOND**
- ✅ Loki - Log aggregation with web UI (Keycloak SSO) - **THIRD**
- ✅ Netdata - Real-time metrics (Keycloak SSO) - **FOURTH**

### 9. Architecture & Design
- ✅ Draw.io - Diagram editor
- ✅ Infrastructure Diagrams - System views

### 6. Common Service URLs
- **External**: `https://[service].ai-servicers.com`
- **Internal**: `http://linuxserver.lan:[port]`
- **OAuth Protected**: Check for OAuth2 proxy containers
- **Local Only**: `http://localhost:[port]`

---
*Created by Claude on 2025-08-24*  
*Last tested and working: 2025-09-01*
*Updated: 2025-09-01 - Added OpenProject and MinIO, reordered Core Services for workflow*