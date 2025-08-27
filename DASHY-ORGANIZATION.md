# Dashy Dashboard Organization Guidelines

## Overview
This document defines the categorization and organization structure for services in the Dashy dashboard at https://dashy.ai-servicers.com

## Current Status Summary
- **Total Services Deployed**: 25+ active services/containers
- **Docker Containers Running**: 21 containers
- **External Services**: 2 (Cloudflare, SendGrid)
- **Categories in Use**: 7 active categories
- **Networks**: 4 Docker networks active
- **Databases Running**: 3 (PostgreSQL, MongoDB, Redis)

### Quick Stats
- **Core Services**: 2 deployed
- **Development Tools**: 4 deployed (Guacamole, GitHub, Nextcloud apps)
- **Infrastructure**: 5 deployed (including Rundeck)
- **Data & Integration**: 3 deployed (pgAdmin, Redis Commander, MongoDB Express)
- **AI Tools**: 2 deployed (OpenWebUI + ChatGPT)
- **Architecture**: 2 deployed (Draw.io + Infrastructure Diagrams)
- **Session Management**: 2 items (OAuth info + Keycloak logout)
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
- ✅ Portainer - http://linuxserver.lan:9000 (Docker management)
- ✅ Traefik Dashboard - https://traefik.ai-servicers.com:8083 (Reverse proxy)
- ✅ Rundeck - http://linuxserver.lan:4440 (Job automation - running 2 months)
- ✅ Postfixadmin (email administration - internal)
- ✅ Keycloak Admin Console (critical service)
- ✅ OAuth2 Proxy userinfo endpoint
- 🚀 Traefik Certs Dumper (certificate management - running)
**Planned**:
- 📋 Nginx Proxy Manager


### 4. Data & Integration Tools
**Icon**: `fas fa-database`  
**Description**: Database management and data integration platforms  
**Currently Active**:
- ✅ pgAdmin - http://linuxserver.lan:8901 (PostgreSQL management)
- ✅ Redis Commander - https://redis.ai-servicers.com (Redis management)
- ✅ MongoDB Express - https://mongodb.ai-servicers.com (MongoDB management)
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
- ✅ OpenWebUI - http://linuxserver.lan:8000 (Local LLM interface)
- ✅ ChatGPT - https://chat.openai.com (External)
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

### 7. Session Management
**Icon**: `fas fa-user-shield`
**Description**: Authentication and session control
**Currently Active**:
- ✅ OAuth2 Session Info (Current session details)
- ✅ Keycloak Logout (Single sign-out)

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
