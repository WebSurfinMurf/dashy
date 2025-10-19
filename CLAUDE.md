# Dashy Dashboard with Keycloak OAuth2 - Lessons Learned

## Working Configuration
**Date**: 2025-08-24
**Status**: ✅ WORKING - Dashy protected by Keycloak OAuth2 authentication
**Last Updated**: 2025-10-19

## Recent Configuration Updates

### 2025-10-19 - Fixed OAuth2 Network Issue ✅

#### Problem
- **Symptom**: OAuth2 proxy returning "Error proxying to upstream server: timeout awaiting response headers"
- **Cause**: Improper network configuration - both dashy and dashy-auth-proxy were on `traefik-net` only
- **Root Issue**: Missing dedicated backend network for OAuth2 proxy to reach Dashy

#### Solution Applied
- **Created `dashy-net`** dedicated backend network
- **Reconfigured networks** following proper OAuth2 pattern:
  - `dashy`: `dashy-net` only (backend isolation)
  - `dashy-auth-proxy`: `traefik-net` + `keycloak-net` + `dashy-net` (three networks required)
- **Updated deploy.sh** to enforce this pattern on every deployment
- **Result**: ✅ Dashy now accessible at https://dashy.ai-servicers.com with proper OAuth2 authentication

#### Key Learning
The OAuth2 proxy pattern documented in `/home/administrator/projects/AINotes/security.md` requires:
1. Backend service isolated on component network only
2. OAuth2 proxy bridging three networks (traefik for web, keycloak for auth, component for backend)
3. Never expose backend directly on traefik-net (security best practice)

## Recent Configuration Updates

### 2025-10-19 - Removed Telegram from Automate & Integ

#### Service Removal
- **Removed Telegram** from Automate & Integ section
  - Entry removed from data/infra.yml
  - Rebuilt Dashy successfully
  - Service confirmed operational at https://dashy.ai-servicers.com
- **Automate & Integ section** now contains n8n and Playwright only (2 services)

### 2025-10-19 - Added Obsidian to AI Tools

#### New Service Addition
- **Added Obsidian** to AI Tools section (first item)
  - Knowledge management and note-taking platform
  - URL: https://obsidian.ai-servicers.com
  - Icon: Dashboard Icons CDN (Obsidian logo)
  - Tags: ai, notes, knowledge, sso
- **Total AI Tools now: 4 services** (Obsidian, OpenWebUI, LangChain Portal, LangSmith)
- **Rebuilt and restarted** Dashy successfully

### 2025-10-10 - Multi-Page Configuration, CSV Import, Reorganization & Refinements

#### New Links Addition (Late Evening - Part 2)
- **Added 9 new links** across multiple tabs:
  - **Video tab, Fav group**: Added YouTube as first item
  - **Agentic AI, OpenAI group**: Added OpenAI Platform (developer console)
  - **Agentic AI, Anthropic group**: Added Anthropic Console (developer console)
  - **Agentic AI, Google group**: Added Google.com (main search)
  - **Agentic AI, Cloud group**: Added AWS Console
  - **Agentic AI, new Info group**: Created group and added TLDR AI Newsletter
  - **Finance, Trading group**: Added TradingView (charting) and Coinbase (crypto)
  - **Finance, Info group**: Added Strategic Forecast Learning
- **Agentic AI expanded to 9 groups** (added Info group for news/newsletters)
- **Finance Trading group expanded** from 2 to 4 services (added TradingView, Coinbase)
- **Total services now 100+** across all pages
- **Rebuilt and restarted** Dashy successfully

#### Multi-Page Setup (Morning)
- **Converted to multi-page layout** - Dashboard now uses multiple pages
- **Created two pages**:
  1. **Home** (infra.yml) - All existing services and admin tools
  2. **Agentic AI** (ai-chat.yml) - AI assistants and resources organized by category
- **Configuration structure**:
  - `conf.yml` - Main config with appConfig, pages list, AND sections (required!)
  - `data/infra.yml` - Home tab content (infrastructure services)
  - `data/ai-chat.yml` - Agentic AI tab content (organized by provider/category)
- **Critical fix**: Main conf.yml MUST have `sections` defined, not just `pages` array
  - Without sections in conf.yml, landing page shows "no data configured"
  - Sections in conf.yml define the default/landing page content
  - Sub-pages (infra.yml, ai-chat.yml) define additional tab content
- **Important**: Page YAML files must be in `data/` directory (mounted to `/app/user-data/` in container)
- **Removed navLinks** from page files (was causing extra tabs to appear as navigation items)
- **Researched solution**: Used Dashy official documentation to understand multi-page requirements
- **Rebuilt and restarted** Dashy successfully

#### Agentic AI Page Expansion (Afternoon - Part 1)
- **Expanded from 3 groups to 8 groups** with comprehensive AI ecosystem coverage:
  1. **OpenAI** - ChatGPT + OpenAI Status page
  2. **Anthropic** - Claude + Claude Status page
  3. **Google** - Gemini + AI Studio
  4. **Other** - Perplexity, Mistral, Meta AI
  5. **Lang** - LangChain, LangFlow frameworks
  6. **Source** - Chainguard, Docker Hub, Microsoft Container Registry
  7. **Models** - Ollama, Hugging Face
  8. **Cloud** - Azure Portal
- **Total AI resources**: 17 services across 8 categories
- **All items use large format** for clean presentation
- **Icons**: Mix of Dashboard Icons CDN and Font Awesome icons

#### CSV Import & Major Reorganization (Evening)
- **Imported 59 personal sites** from `/mnt/shared/dashy.csv`
- **Created 5 new pages**: Finance, Personal, Shopping, Video, Work
- **Consolidated and reorganized** for better logical grouping:
  - Moved Interactive Brokers from separate Trading tab to Finance/Trading group
  - Moved Fidelity from Finance/Accounts to Finance/Trading group
  - Merged Network tab into Personal tab as Network group
  - Split News tab content:
    - Finance news → Finance tab as News group
    - Feed/Other content → Shopping tab as Info group
  - Removed standalone Trading, Network, and News tabs
- **Final structure**: 7 pages (Home, Agentic AI, Finance, Personal, Shopping, Video, Work)
- **Total services**: 90+ items across all pages
- **Security cleanup**: Removed password references from site names in CSV data

#### Video/Work Tab Refinements (Late Evening)
- **Dashy crash fixed**: Container hostname resolution issue - redeployed using deploy.sh
- **Video tab reorganization**:
  - Moved **CBS All Access** from Live group to Stream group (after ESPN+)
  - Moved **Twitch** from Stream group to Live group (first item)
  - Moved **LinkedIn Learning** from Work/Social group to Video/Learn group
- **Work tab cleanup**: Removed Social group (now empty after LinkedIn Learning moved)
- **Learn group updated**: Now has Udemy, LinkedIn Learning, Rotten Tomatoes (3 items)

### 2025-09-05 Changes (Latest)
- **Moved Playwright** from Development Tools to Automate & Integ category
  - Better categorization as it's primarily for browser automation
  - Now grouped with n8n for all automation tools
- **Reorganized section order** for better logical flow:
  1. AI Tools
  2. Development Tools (now contains GitLab and GitHub only)
  3. Automate & Integ (contains n8n and Playwright)
  4. External Services (moved after Automate & Integ)
  5. Infrastructure Management
  6. Security
  7. Core Services
  8. Data Tools (renamed from "Data & Integration Tools")
  9. Logging & Monitoring
  10. Architecture & Design
- **Created "Automate & Integ" category** for automation and integration services
- **Moved n8n** from Development Tools to new Automate & Integ category
- **Renamed** "Data & Integration Tools" to "Data Tools"

### 2025-09-05 Changes (Earlier)
- **Replaced Infisical with OpenBao** in Security section
  - OpenBao is a HashiCorp Vault fork for secrets management
  - URL: https://openbao.ai-servicers.com/ui/vault/auth?with=oidc (direct OIDC login)
  - Icon: fas fa-user-secret (secret agent icon)
  - Tags: security, secrets, sso

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

## Current Pages & Groups Structure (2025-10-10)

### Page 1: Home (infra.yml)
Infrastructure services and admin tools organized by function:

1. **AI Tools**
   - Obsidian - Knowledge management and note-taking
   - OpenWebUI - Local LLM interface
   - LangChain Portal - API directory and quick links
   - LangSmith - Observability platform

2. **Development Tools**
   - GitLab - Git repository and CI/CD
   - GitHub - External code repositories
   - Litellm API - Unified LLM API Gateway

3. **Automate & Integ**
   - n8n - Workflow automation platform
   - Playwright - Browser automation & testing

4. **External Services**
   - Cloudflare - DNS & CDN
   - SendGrid - Email delivery
   - AWS Console - Amazon Web Services
   - Discord Channel - Community server

5. **Infrastructure Management**
   - Portainer - Docker management with SSO
   - Traefik - Reverse proxy (internal access)
   - Litellm UI - AI Gateway Admin Dashboard
   - Postfixadmin - Email admin (internal only)

6. **Security**
   - Keycloak Admin - Identity management
   - Bitwarden - Password manager and secrets vault
   - OAuth2 Session Info - Current session
   - Keycloak Logout - Single sign-out

7. **Core Services**
   - Guacamole - Remote access gateway with SSO
   - OpenProject - Project management platform
   - Web Portal - Main landing page
   - Nextcloud - File sharing platform

8. **Data Tools**
   - pgAdmin - PostgreSQL management (external URL with SSO)
   - Redis Commander - Redis management
   - MongoDB Express - MongoDB management
   - MinIO - S3-compatible object storage

9. **Logging & Monitoring**
   - Dozzle - Real-time container log viewer (Keycloak SSO)
   - Grafana - Metrics and logs visualization dashboard (Keycloak SSO)
   - Loki - Log aggregation with web UI (Keycloak SSO)
   - Netdata - Real-time metrics (Keycloak SSO)

10. **Architecture & Design**
    - Draw.io - Diagram editor
    - Infrastructure Diagrams - System views

### Page 2: Agentic AI (ai-chat.yml)
AI assistants, frameworks, and resources organized by category:

1. **OpenAI Group**
   - ChatGPT - https://chatgpt.com/
   - OpenAI Platform - https://platform.openai.com/
   - OpenAI Status - https://status.openai.com/

2. **Anthropic Group**
   - Claude - https://claude.ai/
   - Anthropic Console - https://console.anthropic.com/
   - Claude Status - https://status.claude.com/

3. **Google Group**
   - Google - https://google.com/
   - Gemini - https://gemini.google.com/
   - AI Studio - https://aistudio.google.com/prompts/new_chat

4. **Other Group**
   - Perplexity - https://www.perplexity.ai/
   - Mistral - https://chat.mistral.ai/chat
   - Meta AI - https://www.meta.ai/

5. **Lang Group** (Frameworks)
   - LangChain - https://www.langchain.com/
   - LangFlow - https://www.langflow.org/

6. **Source Group** (Container Registries)
   - Chainguard - https://www.chainguard.dev/
   - Docker Hub - https://hub.docker.com/
   - Microsoft Container Registry - https://mcr.microsoft.com/en-us/

7. **Models Group** (Model Repositories)
   - Ollama - https://ollama.com/
   - Hugging Face - https://huggingface.co/

8. **Cloud Group**
   - AWS Console - https://aws.amazon.com/
   - Azure Portal - https://portal.azure.com/#home

9. **Info Group**
   - TLDR AI Newsletter - https://tldr.tech/api/latest/ai

### Page 3: Finance (finance.yml)
Financial accounts, trading, news, and market information:

1. **Trading Group**
   - Interactive Brokers
   - Fidelity
   - TradingView
   - Coinbase

2. **Accounts Group**
   - Chase
   - Chase Credit Score
   - 401k

3. **Credit Group**
   - Experian ID Works

4. **News Group**
   - Hussman Funds
   - WebSurfin Murf
   - Mish's Global Economic Trend
   - ChartFreak

5. **Info Group**
   - US Dollar Index
   - Stock Futures
   - DAO
   - Strategic Forecast Learning

### Page 4: Personal (personal.yml)
Personal sites, games, social, and network devices:

1. **Talk Group**
   - Discord
   - Gmail

2. **Game Group**
   - Board Game Arena
   - Dominion Games
   - Dota Picker

3. **Social Group**
   - Facebook

4. **Blog Group**
   - Joey Murphy

5. **Network Group**
   - Access Point (192.168.1.5)
   - Security Camera (192.168.1.31)

### Page 5: Shopping (shopping.yml)
Shopping sites and general information:

1. **Stores Group**
   - Amazon
   - Etsy - Zulu Seeds
   - Fabula Coffee

2. **Info Group**
   - Feedly
   - RationalWiki
   - Weather Underground

### Page 6: Video (video.yml)
Streaming and video services:

1. **Fav Group**
   - YouTube
   - Apple TV
   - Amazon Prime Video
   - HBO Max

2. **Stream Group**
   - Netflix
   - Disney+
   - Paramount+
   - Peacock
   - Hulu
   - PBS
   - ESPN+
   - CBS All Access

3. **Live Group**
   - Twitch
   - YouTube TV
   - Amazon Live TV

4. **Music Group**
   - YouTube Music
   - SiriusXM

5. **Learn Group**
   - Udemy
   - LinkedIn Learning
   - Rotten Tomatoes

### Page 7: Work (work.yml)
Work-related tools and benefits:

1. **Productive Group**
   - Work Email
   - Office Portal
   - OneNote

2. **Benefits Group**
   - Aetna Health
   - Aetna Vision
   - NYLife Benefits
   - Express Scripts
   - NYL Life Insurance
   - PayFlex Portal
   - PayFlex Info

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
docker network disconnect traefik-net dashy 2>/dev/null || true
docker network connect --alias dashy traefik-net dashy
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
- Both containers must be on `traefik-net` network
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
docker run --rm --network traefik-net alpine sh -c "ping -c 1 dashy"
docker run --rm --network traefik-net curlimages/curl curl -I http://dashy:8080

# Check OAuth2 Proxy logs
docker logs dashy-auth-proxy --tail 20

# Force restart to clear cache
docker restart dashy-auth-proxy
```

## Files Structure
```
/home/administrator/projects/dashy/
├── config/
│   └── conf.yml           # Main config (appConfig + pages + sections)
├── data/                  # Dashy persistent data + page files
│   ├── infra.yml          # Home tab content (all admin services)
│   └── ai-chat.yml        # Agentic AI tab (organized by provider)
├── deploy.sh             # Main deployment script
├── setup-keycloak.sh     # One-time Keycloak setup
└── CLAUDE.md             # This documentation
```

## Multi-Page Configuration Notes

**Critical Understanding:**
1. `conf.yml` defines:
   - `appConfig` - Global settings (theme, layout, etc.)
   - `pages` - Array of additional tabs/pages
   - `sections` - **REQUIRED** - Defines the default/landing page content

2. Sub-page files (infra.yml, ai-chat.yml) define:
   - `pageInfo` - Page title and description only
   - `sections` - Content for that specific tab
   - **Cannot include**: `appConfig` or `pages` (inherited from main conf.yml)

3. File locations:
   - `conf.yml` must be in `config/` (bind mounted to `/app/user-data/conf.yml`)
   - Sub-page YML files must be in `data/` (mounted to `/app/user-data/`)

4. After adding/modifying pages:
   - Rebuild required: `docker exec dashy yarn build`
   - Restart container: `docker restart dashy`

**Common Issue**: If landing page shows "no data configured", ensure `sections` are defined directly in `conf.yml`, not just referenced via sub-pages.

## Recovery Procedure
If Dashy stops working:
1. Check container health: `docker ps | grep dashy`
2. Check logs: `docker logs dashy-auth-proxy --tail 50`
3. Verify network alias: `docker exec dashy hostname`
4. Test internal connectivity: `docker run --rm --network traefik-net alpine ping -c 1 dashy`
5. Clear session and retry in incognito mode
6. If stuck, kill containers properly before restarting:
   ```bash
   docker kill dashy dashy-auth-proxy
   docker rm dashy dashy-auth-proxy
   ./deploy.sh
   ```

## Adding New Items to Agentic AI Page

To add more AI services to the Agentic AI page:

### Edit the ai-chat.yml file
```bash
vi /home/administrator/projects/dashy/data/ai-chat.yml
```

### Add items to appropriate section
```yaml
- name: OpenAI
  items:
  - title: ChatGPT
    # ... existing item ...
  - title: New OpenAI Service  # Add here
    description: Description of new service
    icon: https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/png/openai.png
    url: https://service.url
    target: newtab
    tags:
    - ai
    - openai
```

### Rebuild and restart
```bash
docker exec dashy yarn build
docker restart dashy
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

## Dashboard Statistics (2025-10-19)

### Overview
- **Total Pages**: 7 (Home, Agentic AI, Finance, Personal, Shopping, Video, Work)
- **Total Groups**: 42 groups across all pages
- **Total Services**: 100+ services/links across all pages
- **Authentication**: All infrastructure services protected by Keycloak OAuth2

### Page Distribution
- **Home (Infrastructure/Admin)**: 10 groups, ~29 services (removed Telegram)
- **Agentic AI**: 9 groups, 23 AI resources (added developer consoles, cloud, info)
- **Finance**: 5 groups, 17 financial services (added TradingView, Coinbase, Strategic Forecast)
- **Personal**: 5 groups, 10 personal sites
- **Shopping**: 2 groups, 6 shopping/info sites
- **Video**: 5 groups, 24 streaming/learning services (added YouTube)
- **Work**: 2 groups, 12 work tools

### URL Types
- **Internal Infrastructure**: `https://[service].ai-servicers.com` (Keycloak SSO)
- **External Services**: Direct HTTPS links to third-party platforms
- **Local Network**: `http://192.168.1.x` (network devices)
- **Internal Only**: `http://linuxserver.lan:[port]`

### Quick Access by Category
- **AI Chat**: ChatGPT, Claude, Gemini, Perplexity, Mistral, Meta AI
- **AI Developer Consoles**: OpenAI Platform, Anthropic Console, Google AI Studio
- **Cloud Platforms**: AWS Console, Azure Portal
- **Financial**: Chase, Fidelity, Interactive Brokers, TradingView, Coinbase, 401k, Experian
- **Streaming**: YouTube, Netflix, Disney+, HBO Max, Hulu, Amazon Prime, Apple TV
- **Work**: Microsoft 365, Aetna, NYLife, LinkedIn Learning
- **Monitoring**: Dozzle, Grafana, Loki, Netdata (all Keycloak SSO)
- **Management**: Portainer, Keycloak, Traefik (all Keycloak SSO)
- **Development**: GitLab, GitHub, n8n, Playwright

---
*Created by Claude on 2025-08-24*
*Last updated: 2025-10-19 (Removed Telegram from Automate & Integ section)*
*Status: ✅ Fully operational - 7 pages, 42 groups, 100+ services*