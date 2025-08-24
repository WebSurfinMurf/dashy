# Dashy Dashboard with Keycloak OAuth2 - Lessons Learned

## Working Configuration
**Date**: 2025-08-24  
**Status**: ✅ WORKING - Dashy protected by Keycloak OAuth2 authentication

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

---
*Created by Claude on 2025-08-24*  
*Last tested and working: 2025-08-24*