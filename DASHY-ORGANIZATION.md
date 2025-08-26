# Dashy Dashboard Organization Guidelines

## Overview
This document defines the categorization and organization structure for services in the Dashy dashboard at https://dashy.ai-servicers.com

## Current Status Summary <UPDATE>
- **Total Services Deployed**: 12 active services
- **In Dashy**: 10 services (✅)
- **Need Adding**: 1 service (🚀 phpMyAdmin)
- **Planned**: 23+ services (📋)
- **Categories in Use**: 4 out of 11 categories have active services

### Quick Stats <UPDATE>
- **Core Services**: 2 deployed, 3 planned
- **Email Services**: 3 deployed (all configured)
- **Infrastructure**: 4 deployed, 1 needs adding
- **Authentication**: 2 deployed (all configured)
- **Databases**: 2 backend services running
- **Networks**: 4 Docker networks active

## Service Categories

### 1. Core Services
**Icon**: `fas fa-server`  
**Description**: Essential self-hosted services and collaboration platforms  
**Currently Active**:
- ✅ Nextcloud (file sharing and collaboration)
- Web Portal (https://nginx.ai-servicers.com/) <FIX SYNTAX OF THIS LINE>

### 2. Development Tools
**Icon**: `fas fa-code`  
**Description**: Development and CI/CD tools  
**Currently Active**: None
- ✅ Guacamole (remote access gateway with SSO)
- ✅ GitHub repositories (external)
- Nextcloud Talk <FIX SYNTAX OF THIS LINE>
- Nextcloud fileshare <FIX SYNTAX OF THIS LINE>
**Planned**:
- 📋 Code-server (VS Code in browser)
- 📋 GitLab

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
**Description**: Database management interfaces  
**Currently Active**:
- ✅ pgAdmin (PostgreSQL management - internal)
- Redis Commander <FIX SYNTAX OF THIS LINE>
- MongoDB Express <FIX SYNTAX OF THIS LINE>
**Backend Services** (not in Dashy):
- 🚀 PostgreSQL (port 5432)
- 🚀 MariaDB (port 3306)
**Planned**:
- 📋 Kafka
- 📋 Paperless-ngx (document management)

### 5. AI Tools
**Icon**: <UPDATE>
**Description**: <UPDATE>
**Currently Active**: 
OpenWeb UI ( http://linuxserver.lan:8000/ )
ChatGPT (external)
**Planned**:
ClaudeCodeUI(siteboon)

### 6. Architecture
**Icon**: `fas fa-comments`  
**Description**: Team communication and messaging  
**Currently Active**: 
Draw-IO
**Planned**:

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
cloudflare ( https://dash.cloudflare.com/ )
Sendgrid https://app.sendgrid.com/
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
- Guacamole, Guac


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
