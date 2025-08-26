# Dashy Dashboard Organization Guidelines

## Overview
This document defines the categorization and organization structure for services in the Dashy dashboard at https://dashy.ai-servicers.com

## Current Status Summary
- **Total Services Deployed**: 12 active services
- **In Dashy**: 10 services (✅)
- **Need Adding**: 1 service (🚀 phpMyAdmin)
- **Planned**: 23+ services (📋)
- **Categories in Use**: 4 out of 11 categories have active services

### Quick Stats
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
- ✅ Guacamole (remote access gateway with SSO)
**Planned**:
- 📋 Vaultwarden (password manager)
- 📋 Gitea (git hosting)
- 📋 Wiki.js (documentation)

### 2. Email Services  
**Icon**: `fas fa-envelope`  
**Description**: Email infrastructure and management  
**Currently Active**:
- ✅ Roundcube (webmail)
- ✅ Snappymail (modern webmail)
- ✅ Postfixadmin (email administration - internal)

### 3. Infrastructure Management
**Icon**: `fas fa-tools`  
**Description**: System administration and monitoring tools  
**Currently Active**:
- ✅ Portainer (Docker management - internal)
- ✅ Traefik Dashboard (reverse proxy with basic auth)
- ✅ pgAdmin (PostgreSQL management - internal)
- 🚀 phpMyAdmin (MySQL management - needs adding)
**Planned**:
- 📋 Uptime Kuma (monitoring)
- 📋 Nginx Proxy Manager

### 4. Authentication & Security
**Icon**: `fas fa-shield-alt`  
**Description**: Identity management and security services  
**Currently Active**:
- ✅ Keycloak Admin Console (critical service)
- ✅ OAuth2 Proxy userinfo endpoint
**Planned**:
- 📋 Fail2ban Dashboard
- 📋 CrowdSec Dashboard

### 5. Development Tools
**Icon**: `fas fa-code`  
**Description**: Development and CI/CD tools  
**Currently Active**: None
**Planned**:
- 📋 Jenkins (CI/CD)
- 📋 Gitea (git hosting)
- 📋 Code-server (VS Code in browser)
- 📋 GitLab
- 📋 SonarQube (code quality)

### 6. Database Tools
**Icon**: `fas fa-database`  
**Description**: Database management interfaces  
**Currently Active**:
- ✅ pgAdmin (PostgreSQL - internal)
- 🚀 phpMyAdmin (MySQL/MariaDB - needs adding)
**Backend Services** (not in Dashy):
- 🚀 PostgreSQL (port 5432)
- 🚀 MariaDB (port 3306)
**Planned**:
- 📋 MongoDB Express
- 📋 Redis Commander
- 📋 InfluxDB UI

### 7. Monitoring & Analytics
**Icon**: `fas fa-chart-line`  
**Description**: System monitoring and analytics platforms  
**Currently Active**: None
**Planned**:
- 📋 Grafana (metrics visualization)
- 📋 Uptime Kuma (uptime monitoring)
- 📋 Prometheus (metrics collection)
- 📋 Netdata (real-time monitoring)
- 📋 Plausible Analytics (web analytics)

### 8. Communication Tools
**Icon**: `fas fa-comments`  
**Description**: Team communication and messaging  
**Currently Active**: None
**Planned**:
- 📋 Mattermost (team chat)
- 📋 Rocket.Chat (alternative chat)
- 📋 Element/Matrix (decentralized chat)
- 📋 Jitsi Meet (video conferencing)

### 9. Media & Content
**Icon**: `fas fa-photo-video`  
**Description**: Media servers and content management  
**Currently Active**: None
**Planned**:
- 📋 Jellyfin/Plex (media server)
- 📋 PhotoPrism (photo management)
- 📋 Paperless-ngx (document management)
- 📋 Calibre-web (ebook library)

### 10. Documentation
**Icon**: `fas fa-book`  
**Description**: Documentation and knowledge bases  
**Currently Active**: None
**Planned**:
- 📋 Wiki.js (modern wiki platform)
- 📋 BookStack (structured documentation)
- 📋 Outline (knowledge base)

### 11. External Services
**Icon**: `fas fa-globe`  
**Description**: External SaaS and third-party services  
**Currently Active**:
- ✅ GitHub repositories (if configured)
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

## Deployment Status Tracking

### Service Status Legend
- ✅ **In Dashy** - Deployed and configured in dashboard
- 🚀 **Deployed** - Running but not yet added to Dashy
- 📋 **Planned** - Not yet deployed

### Current Service Status

#### Core Services
- ✅ **Nextcloud** - https://nextcloud.ai-servicers.com (File sharing and collaboration)
- ✅ **Guacamole** - https://guacamole.ai-servicers.com (Remote desktop gateway with Keycloak SSO)
- 📋 **Vaultwarden** - https://vault.ai-servicers.com (Password manager - planned)
- 📋 **Wiki.js** - https://wiki.ai-servicers.com (Documentation platform - planned)
- 📋 **Gitea** - https://git.ai-servicers.com (Git hosting - planned)

#### Email Services  
- ✅ **Roundcube** - https://mail.ai-servicers.com (Traditional webmail)
- ✅ **Snappymail** - https://snappy.ai-servicers.com (Modern webmail)
- ✅ **Postfixadmin** - http://linuxserver.lan:8902 (Email admin - internal only)

#### Infrastructure Management
- ✅ **Portainer** - http://linuxserver.lan:9000 (Docker management - internal)
- ✅ **Traefik Dashboard** - https://traefik.ai-servicers.com:8083 (Reverse proxy - basic auth)
- ✅ **pgAdmin** - http://linuxserver.lan:8901 (PostgreSQL management - internal)
- 🚀 **phpMyAdmin** - http://linuxserver.lan:8903 (MySQL management - deployed, not in Dashy)

#### Authentication & Security
- ✅ **Keycloak Admin** - https://keycloak.ai-servicers.com (Identity management - critical)
- ✅ **Dashy OAuth Info** - https://dashy.ai-servicers.com/oauth2/userinfo (Session info)

#### Monitoring & Analytics
- 📋 **Uptime Kuma** - https://uptime.ai-servicers.com (Uptime monitoring - planned)
- 📋 **Grafana** - https://grafana.ai-servicers.com (Metrics visualization - planned)

#### Development Tools
- 📋 **Jenkins** - https://jenkins.ai-servicers.com (CI/CD - planned)

#### Database Services (Backend)
- 🚀 **PostgreSQL** - Port 5432 (Primary database - running)
- 🚀 **MariaDB** - Port 3306 (Mailserver database - running)

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

## Action Items

### Services to Add to Dashy (Already Deployed)
1. 🚀 **phpMyAdmin** - http://linuxserver.lan:8903
   - Category: Database Tools
   - Icon: `phpmyadmin.png`
   - Internal access only

### Services to Deploy Next
Priority order based on usefulness:
1. 📋 **Uptime Kuma** - Service monitoring
2. 📋 **Vaultwarden** - Password management
3. 📋 **Wiki.js** - Documentation
4. 📋 **Gitea** - Git repository hosting
5. 📋 **Grafana** - Metrics visualization
6. 📋 **Jenkins** - CI/CD automation

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