# Dashy Dashboard Organization Guidelines

## Overview
This document defines the categorization and organization structure for services in the Dashy dashboard at https://dashy.ai-servicers.com

## Current Status Summary
- **Total Services Deployed**: 20+ active services
- **In Dashy**: Need to recount based on new categorization
- **External Services**: 4 (GitHub, ChatGPT, Cloudflare, SendGrid)
- **Categories in Use**: 8 active categories
- **Networks**: 4 Docker networks active

### Quick Stats
- **Core Services**: 2 deployed
- **Development Tools**: 5 deployed
- **Infrastructure**: 5 deployed
- **Data & Integration**: 3+ deployed
- **AI Tools**: 2 deployed (OpenWebUI + ChatGPT)
- **Architecture**: 1 deployed (Draw.io)
- **External Services**: 4 active

## Service Categories

### 1. Core Services
**Icon**: `fas fa-server`  
**Description**: Essential self-hosted services and collaboration platforms  
**Currently Active**:
- ✅ Nextcloud (file sharing and collaboration)
- ✅ Web Portal - https://nginx.ai-servicers.com (Main landing page)

### 2. Development Tools
**Icon**: `fas fa-code`  
**Description**: Development and CI/CD tools  
**Currently Active**:
- ✅ Guacamole (remote access gateway with SSO)
- ✅ GitHub repositories (external)
- ✅ Nextcloud Talk (integrated communication)
- ✅ Nextcloud Files (code collaboration)
**Planned**:
- 📋 Code-server (VS Code in browser)
- 📋 GitLab
- 📋 Gitea

### 3. Infrastructure Management
**Icon**: `fas fa-tools`  
**Description**: System administration and monitoring tools  
**Currently Active**:
- ✅ Portainer (Docker management - internal)
- ✅ Traefik Dashboard (reverse proxy with basic auth)
- ✅ Postfixadmin (email administration - internal)
- ✅ Keycloak Admin Console (critical service)
- ✅ OAuth2 Proxy userinfo endpoint
**Planned**:
- 📋 Nginx Proxy Manager


### 4. Data & Integration Tools
**Icon**: `fas fa-database`  
**Description**: Database management and data integration platforms  
**Currently Active**:
- ✅ pgAdmin (PostgreSQL management - internal)
- 🚀 Redis Commander (Redis management - if deployed)
- 🚀 MongoDB Express (MongoDB management - if deployed)
**Backend Services** (not in Dashy):
- 🚀 PostgreSQL (port 5432)
- 🚀 MariaDB (port 3306)
**Planned**:
- 📋 Kafka (message streaming)
- 📋 Paperless-ngx (document management)
- 📋 n8n (workflow automation)

### 5. AI Tools
**Icon**: `fas fa-robot`
**Description**: AI assistants and machine learning platforms
**Currently Active**: 
- ✅ OpenWebUI - http://linuxserver.lan:8000 (Local LLM interface)
- ✅ ChatGPT - https://chat.openai.com (External)
**Planned**:
- 📋 Claude Code UI (Siteboon)
- 📋 Ollama (Local LLM runtime)
- 📋 Stable Diffusion WebUI

### 6. Architecture & Design
**Icon**: `fas fa-project-diagram`  
**Description**: Diagramming and system design tools  
**Currently Active**: 
- ✅ Draw.io (Diagram editor)
**Planned**:
- 📋 PlantUML Server
- 📋 Excalidraw
- 📋 Kroki (diagram rendering service)

### 7. Monitoring & Analytics
**Icon**: `fas fa-chart-line`  
**Description**: System monitoring and analytics platforms  
**Currently Active**: None
**Planned**:
- 📋 Grafana (metrics visualization)
- 📋 Uptime Kuma (uptime monitoring)
- 📋 Netdata (real-time monitoring)


### 8. External Services
**Icon**: `fas fa-globe`  
**Description**: External SaaS and third-party services  
**Currently Active**:
- ✅ Cloudflare - https://dash.cloudflare.com (DNS & CDN)
- ✅ SendGrid - https://app.sendgrid.com (Email delivery)
- ✅ GitHub - https://github.com (Code repositories)
- ✅ ChatGPT - https://chat.openai.com (AI assistant)
**Potential additions**:
- Domain registrar panel
- Cloud provider dashboards
- External monitoring services

## Configuration Standards

### Item Structure
Each service item should include:
```yaml
- title: Service Name
  description: Brief description (max 50 chars)
  icon: <icon-url-or-fontawesome>
  url: https://service.domain.com
  target: newtab
  statusCheck: true
  tags:
    - relevant
    - tags
```

### Icon Sources
1. **Dashboard Icons CDN**: `https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/png/[service].png`
2. **Font Awesome**: `fas fa-[icon-name]` or `fab fa-[brand]`
3. **Material Design Icons**: `mdi-[icon-name]`
4. **Custom URLs**: Direct links to PNG/SVG icons

### Color Scheme
- Use consistent theme: `nord-frost` (current)
- Section colors can be customized with `color` attribute
- Item background colors for emphasis: `#1a1a2e`, `#16213e`, `#0f3460`

### Tags System
Standard tags to use:
- `admin` - Administrative interfaces
- `public` - Publicly accessible
- `internal` - Internal network only
- `critical` - Critical infrastructure
- `monitoring` - Monitoring tools
- `database` - Database related
- `auth` - Authentication related
- `dev` - Development tools
- `prod` - Production services


## Docker Network Topology

### Active Networks and Services

#### traefik-proxy
Main reverse proxy network connecting:
- Traefik, Keycloak, Dashy, OAuth2-Proxy
- Nextcloud, Guacamole

#### mailserver-net
Email services network:
- Mailserver, Roundcube, Snappymail, Postfixadmin

#### postgres-net
PostgreSQL database network:
- PostgreSQL, pgAdmin, Guacamole

#### guacamole-net
Guacamole internal network:
- Guacamole, Guacd


## Update Procedure

When updating Dashy configuration:
1. Review this organization guide
2. Check current deployment status
3. Run `./update-dashy.sh` for guided updates
4. Group services according to categories
5. Maintain consistent naming and descriptions
6. Test status checks after deployment
7. Update both this document and SERVICES-INVENTORY.yml

## Navigation Links
Top navigation should include quick access to:
1. Keycloak Admin
2. Traefik Dashboard  
3. pgAdmin
4. Portainer
5. Primary documentation

## Best Practices

### DO:
- Keep descriptions concise and informative
- Use status checks for critical services
- Group related services together
- Use consistent icon style within sections
- Add tags for filtering capability

### DON'T:
- Mix internal and external services in same section
- Use long descriptions that break layout
- Forget to test links after deployment
- Use inconsistent naming conventions
- Expose sensitive admin panels publicly

## Service Addition Checklist
When adding a new service:
- [ ] Determine appropriate category
- [ ] Find suitable icon (check Dashboard Icons first)
- [ ] Write concise description
- [ ] Verify URL is correct
- [ ] Add relevant tags
- [ ] Test status check functionality
- [ ] Update this document
- [ ] Commit configuration changes





---
*Last Updated: 2025-08-26*  
*Maintained for: ai-servicers.com admin dashboard*
