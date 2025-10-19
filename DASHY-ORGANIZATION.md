# Dashy Dashboard Organization Guidelines

## Overview
This document defines the categorization and organization structure for services in the Dashy dashboard at https://dashy.ai-servicers.com

## Current Status Summary (2025-08-27)
- **Total Services Deployed**: 25+ active services/containers
- **Docker Containers Running**: 30+ containers (including OAuth2 proxies)
- **External Services with SSO**: 7 (Dashy, Portainer, MongoDB Express, Redis Commander, GitLab, Guacamole, Keycloak)
- **Internal-Only Services**: 4 (Traefik Dashboard, pgAdmin, Rundeck, Postfixadmin)
- **Categories in Use**: 8 active categories (including Security)
- **Networks**: 5 Docker networks active (traefik-net, keycloak-net, mailserver-net, postgres-net, guacamole-net)
- **Databases Running**: 3 (PostgreSQL, MongoDB, Redis)

### Quick Stats
- **Core Services**: 2 deployed (Nextcloud, Web Portal)
- **Development Tools**: 3 deployed (GitLab, Guacamole, GitHub)
- **Infrastructure**: 5 deployed (Portainer, Traefik, Rundeck, Postfixadmin, Keycloak Admin)
- **Data & Integration**: 3 deployed (pgAdmin, Redis Commander, MongoDB Express)
- **AI Tools**: 2 deployed (OpenWebUI, ChatGPT)
- **Architecture**: 2 deployed (Draw.io, Infrastructure Diagrams)
- **Security**: 3 items (Keycloak Admin, OAuth2 Session Info, Keycloak Logout)
- **External Services**: 2 active (Cloudflare, SendGrid)

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
- ✅ GitLab - https://gitlab.ai-servicers.com (Git repository and CI/CD)
- ✅ Guacamole - https://guacamole.ai-servicers.com (remote access gateway with SSO)
- ✅ GitHub - https://github.com (external repositories)
**Planned**:
- 📋 Code-server (VS Code in browser)
- 📋 Gitea (lightweight Git service)

### 3. Infrastructure Management
**Icon**: `fas fa-tools`  
**Description**: System administration and monitoring tools  
**Currently Active**:
- ✅ Portainer - https://portainer.ai-servicers.com (Docker management - Keycloak SSO + local auth)
- ✅ Traefik Dashboard - http://linuxserver.lan:8083 (Reverse proxy - internal only)
- ✅ Rundeck - http://linuxserver.lan:4440 (Job automation - internal only)
- ✅ Postfixadmin - https://postfixadmin.linuxserver.lan (email administration - internal only)
**Backend Services** (running):
- 🚀 Traefik Certs Dumper (certificate management)
- 🚀 OAuth2 Proxy containers (protecting services)
**Planned**:
- 📋 Nginx Proxy Manager
- 📋 Rancher (potential Portainer replacement)


### 4. Data & Integration Tools
**Icon**: `fas fa-database`  
**Description**: Database management and data integration platforms  
**Currently Active**:
- ✅ pgAdmin - http://linuxserver.lan:8901/browser/ (PostgreSQL management - internal only)
- ✅ Redis Commander - https://redis.ai-servicers.com (Redis management - Keycloak SSO)
- ✅ MongoDB Express - https://mongodb.ai-servicers.com (MongoDB management - Keycloak SSO)
**Backend Services** (running):
- 🚀 PostgreSQL (port 5432)
- 🚀 MongoDB (port 27017) 
- 🚀 Redis (port 6379)
**Planned**:
- 📋 phpMyAdmin (MySQL/MariaDB management)
- 📋 Kafka (message streaming)
- 📋 Paperless-ngx (document management)
- 📋 n8n (workflow automation)

### 5. AI Tools
**Icon**: `fas fa-robot`
**Description**: AI assistants and machine learning platforms
**Currently Active**: 
- ✅ OpenWebUI - https://open-webui.ai-servicers.com (Local LLM interface - external access)
- ✅ ChatGPT - https://chat.openai.com (External service)
**Planned**:
- 📋 Claude Code UI (Web interface)
- 📋 Ollama (Local LLM runtime)
- 📋 Stable Diffusion WebUI

### 6. Architecture & Design
**Icon**: `fas fa-project-diagram`  
**Description**: Diagramming and system design tools  
**Currently Active**: 
- ✅ Draw.io - https://drawio.ai-servicers.com (Diagram editor)
- ✅ Infrastructure Diagrams - https://diagrams.nginx.ai-servicers.com (System views)
**Planned**:
- 📋 PlantUML Server
- 📋 Excalidraw
- 📋 Kroki (diagram rendering service)

### 7. Security
**Icon**: `fas fa-user-shield`
**Description**: Identity management and security services
**Currently Active**:
- ✅ Keycloak Admin - https://keycloak.ai-servicers.com/admin/ (Identity management)
- ✅ OAuth2 Session Info - https://dashy.ai-servicers.com/oauth2/userinfo (Current session details)
- ✅ Keycloak Logout - https://keycloak.ai-servicers.com/realms/master/protocol/openid-connect/logout (Single sign-out)

### 8. Monitoring & Analytics
**Icon**: `fas fa-chart-line`  
**Description**: System monitoring and analytics platforms  
**Currently Active**: None
**Planned**:
- 📋 Grafana (metrics visualization)
- 📋 Uptime Kuma (uptime monitoring)
- 📋 Netdata (real-time monitoring)

### 9. External Services
**Icon**: `fas fa-globe`  
**Description**: External SaaS and third-party services  
**Currently Active**:
- ✅ Cloudflare - https://dash.cloudflare.com (DNS & CDN)
- ✅ SendGrid - https://app.sendgrid.com (Email delivery)
**Note**: GitHub and ChatGPT listed in their respective categories (Development/AI Tools)

## URL Access Patterns

### External Services (HTTPS via Traefik)
Services accessible from the internet with SSL certificates:
- **Pattern**: `https://[service].ai-servicers.com`
- **Examples**:
  - Dashy: https://dashy.ai-servicers.com (with Keycloak SSO)
  - Portainer: https://portainer.ai-servicers.com (with Keycloak SSO + local auth)
  - MongoDB Express: https://mongodb.ai-servicers.com (with Keycloak SSO)
  - Redis Commander: https://redis.ai-servicers.com (with Keycloak SSO)
  - OpenWebUI: https://open-webui.ai-servicers.com (public access)
  - Keycloak: https://keycloak.ai-servicers.com (identity provider)
  - GitLab: https://gitlab.ai-servicers.com (Git service)
  - Guacamole: https://guacamole.ai-servicers.com (remote access with SSO)
  - Nextcloud: https://nextcloud.ai-servicers.com (file sharing)
  - Draw.io: https://drawio.ai-servicers.com (diagram editor)
  - Web Portal: https://nginx.ai-servicers.com (main landing)

### Internal Services (LAN only)
Services only accessible on local network:
- **Pattern**: `http://linuxserver.lan:[port]` or `https://[service].linuxserver.lan`
- **Examples**:
  - Traefik Dashboard: http://linuxserver.lan:8083
  - pgAdmin: http://linuxserver.lan:8901/browser/
  - Rundeck: http://linuxserver.lan:4440
  - Postfixadmin: https://postfixadmin.linuxserver.lan

### Navigation Bar Priority
Top navigation should show most-used admin tools:
1. Keycloak Admin - https://keycloak.ai-servicers.com/admin/ (external)
2. Traefik Dashboard - http://linuxserver.lan:8083 (internal)
3. pgAdmin - http://linuxserver.lan:8901/browser/ (internal)
4. Portainer - https://portainer.ai-servicers.com (external)
5. Rundeck - http://linuxserver.lan:4440 (internal)

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

#### traefik-net
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

## Important Notes

### Authentication Layers
- **Keycloak SSO Services**: Dashy, MongoDB Express, Redis Commander, Guacamole, GitLab
- **Keycloak + Local Auth**: Portainer (CE limitation - requires both OAuth2 and local login)
- **Local Auth Only**: pgAdmin, Rundeck, Traefik Dashboard, Postfixadmin
- **Public Access**: OpenWebUI, Web Portal (nginx.ai-servicers.com), Draw.io, Infrastructure Diagrams

### Portainer Special Case
Portainer Community Edition doesn't support SSO passthrough. Users must:
1. First authenticate via Keycloak (OAuth2 Proxy)
2. Then log into Portainer with local credentials
This is a CE limitation; Business Edition supports full SSO.

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
*Last Updated: 2025-08-27*  
*Maintained for: ai-servicers.com admin dashboard*

## Recent Changes (2025-08-27)
- ✅ Added Portainer with Keycloak OAuth2 (two-layer auth due to CE limitations)
- ✅ Updated all service URLs to correct internal/external patterns
- ✅ Fixed Traefik Dashboard to internal-only access (http://linuxserver.lan:8083)
- ✅ Confirmed OpenWebUI has external access (https://open-webui.ai-servicers.com)
- ✅ Confirmed pgAdmin is internal-only (http://linuxserver.lan:8901/browser/)
- ✅ Added GitLab to Development Tools section
- ✅ Reorganized Security section (formerly Session Management)
- ✅ Documented authentication patterns for each service
- ✅ Added complete URL reference for all services
