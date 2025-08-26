# Dashy Dashboard Organization Guidelines

## Overview
This document defines the categorization and organization structure for services in the Dashy dashboard at https://dashy.ai-servicers.com

## Service Categories

### 1. Core Services
**Icon**: `fas fa-server`  
**Description**: Essential self-hosted services and collaboration platforms  
**Services to include**:
- Nextcloud (file sharing and collaboration)
- Guacamole (remote access gateway)
- Vaultwarden (password manager)
- Gitea (git hosting)
- Wiki.js (documentation)

### 2. Email Services  
**Icon**: `fas fa-envelope`  
**Description**: Email infrastructure and management  
**Services to include**:
- Roundcube (webmail)
- Snappymail (modern webmail)
- Postfixadmin (email administration)
- Mail server status/health

### 3. Infrastructure Management
**Icon**: `fas fa-tools`  
**Description**: System administration and monitoring tools  
**Services to include**:
- Portainer (Docker management)
- Traefik Dashboard (reverse proxy)
- pgAdmin (PostgreSQL management)
- phpMyAdmin (MySQL management)
- Nginx Proxy Manager (if deployed)
- Uptime Kuma (monitoring)

### 4. Authentication & Security
**Icon**: `fas fa-shield-alt`  
**Description**: Identity management and security services  
**Services to include**:
- Keycloak Admin Console
- OAuth2 Proxy endpoints
- Fail2ban Dashboard (if available)
- CrowdSec Dashboard (if deployed)

### 5. Development Tools
**Icon**: `fas fa-code`  
**Description**: Development and CI/CD tools  
**Services to include**:
- Jenkins (CI/CD)
- GitLab (if deployed)
- Code-server (VS Code in browser)
- Jupyter (if deployed)
- SonarQube (code quality)

### 6. Database Tools
**Icon**: `fas fa-database`  
**Description**: Database management interfaces  
**Services to include**:
- pgAdmin (PostgreSQL)
- phpMyAdmin (MySQL/MariaDB)
- MongoDB Express (if MongoDB deployed)
- Redis Commander (if Redis deployed)
- InfluxDB UI (if deployed)

### 7. Monitoring & Analytics
**Icon**: `fas fa-chart-line`  
**Description**: System monitoring and analytics platforms  
**Services to include**:
- Grafana (metrics visualization)
- Prometheus (metrics collection)
- Uptime Kuma (uptime monitoring)
- Netdata (real-time monitoring)
- Plausible Analytics (web analytics)

### 8. Communication Tools
**Icon**: `fas fa-comments`  
**Description**: Team communication and messaging  
**Services to include**:
- Mattermost (team chat)
- Rocket.Chat (alternative chat)
- Element/Matrix (decentralized chat)
- Jitsi Meet (video conferencing)

### 9. Media & Content
**Icon**: `fas fa-photo-video`  
**Description**: Media servers and content management  
**Services to include**:
- Jellyfin/Plex (media server)
- PhotoPrism (photo management)
- Paperless-ngx (document management)
- Calibre-web (ebook library)

### 10. Documentation
**Icon**: `fas fa-book`  
**Description**: Documentation and knowledge bases  
**Services to include**:
- Wiki.js
- BookStack
- Confluence (if deployed)
- Project documentation links

### 11. External Services
**Icon**: `fas fa-globe`  
**Description**: External SaaS and third-party services  
**Services to include**:
- GitHub repositories
- External monitoring
- Cloud provider dashboards
- Domain registrar panels

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

### Currently Deployed Services
Mark with ✅ when added to Dashy:
- ✅ Nextcloud
- ✅ Keycloak
- ✅ Traefik
- ✅ pgAdmin
- ✅ Portainer
- ✅ Roundcube
- ✅ Snappymail
- ✅ Postfixadmin
- ✅ Guacamole
- ⬜ Vaultwarden
- ⬜ Wiki.js
- ⬜ Gitea
- ⬜ Uptime Kuma
- ⬜ Grafana

## Update Procedure

When updating Dashy configuration:
1. Review this organization guide
2. Check current deployment status
3. Group services according to categories
4. Maintain consistent naming and descriptions
5. Test status checks after deployment
6. Update this document with new services

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