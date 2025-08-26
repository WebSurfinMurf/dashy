#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== Dashy Configuration Update Tool ===${NC}"
echo ""

# Function to backup current config
backup_config() {
    echo -e "${YELLOW}Creating backup of current configuration...${NC}"
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    cp config/conf.yml "config/conf.yml.backup.${TIMESTAMP}"
    echo -e "${GREEN}✓ Backup created: config/conf.yml.backup.${TIMESTAMP}${NC}"
}

# Function to validate YAML
validate_yaml() {
    echo -e "${YELLOW}Validating YAML configuration...${NC}"
    if docker run --rm -v "$(pwd)/config:/config" alpine sh -c "apk add --no-cache yamllint >/dev/null 2>&1 && yamllint -d relaxed /config/conf.yml"; then
        echo -e "${GREEN}✓ Configuration is valid${NC}"
        return 0
    else
        echo -e "${RED}✗ Configuration has errors${NC}"
        return 1
    fi
}

# Function to reload Dashy
reload_dashy() {
    echo -e "${YELLOW}Reloading Dashy configuration...${NC}"
    
    # Check if Dashy is running
    if docker ps | grep -q "dashy"; then
        # Dashy auto-reloads config changes, but we can force it
        docker exec dashy sh -c "kill -HUP 1" 2>/dev/null || true
        echo -e "${GREEN}✓ Configuration reloaded${NC}"
        echo -e "${BLUE}Note: Changes should appear within 30 seconds${NC}"
    else
        echo -e "${RED}Dashy is not running. Start it with ./deploy.sh${NC}"
    fi
}

# Function to add a new service
add_service() {
    echo -e "${BLUE}=== Add New Service ===${NC}"
    echo ""
    
    # Show available categories
    echo "Available categories:"
    echo "1. Core Services"
    echo "2. Email Services"
    echo "3. Infrastructure Management"
    echo "4. Authentication & Security"
    echo "5. Development Tools"
    echo "6. Database Tools"
    echo "7. Monitoring & Analytics"
    echo "8. Communication Tools"
    echo "9. Media & Content"
    echo "10. Documentation"
    echo "11. External Services"
    echo ""
    
    read -p "Select category (1-11): " category
    read -p "Service title: " title
    read -p "Service description: " description
    read -p "Service URL: " url
    read -p "Icon (FontAwesome or URL): " icon
    read -p "Enable status check? (y/n): " status_check
    
    # Convert status check to boolean
    if [[ $status_check == "y" ]]; then
        status_check="true"
    else
        status_check="false"
    fi
    
    echo ""
    echo -e "${YELLOW}Service to add:${NC}"
    echo "Category: $category"
    echo "Title: $title"
    echo "Description: $description"
    echo "URL: $url"
    echo "Icon: $icon"
    echo "Status Check: $status_check"
    echo ""
    
    read -p "Add this service? (y/n): " confirm
    if [[ $confirm == "y" ]]; then
        echo -e "${GREEN}✓ Service configuration ready${NC}"
        echo -e "${YELLOW}Please manually add to config/conf.yml in the appropriate section${NC}"
    fi
}

# Function to show menu
show_menu() {
    echo "What would you like to do?"
    echo "1. Backup current configuration"
    echo "2. Validate configuration"
    echo "3. Reload Dashy (apply changes)"
    echo "4. Add new service (guided)"
    echo "5. View organization guidelines"
    echo "6. Edit configuration file"
    echo "7. View current configuration"
    echo "8. Restore from backup"
    echo "9. Exit"
    echo ""
}

# Main loop
while true; do
    echo ""
    show_menu
    read -p "Select option (1-9): " choice
    echo ""
    
    case $choice in
        1)
            backup_config
            ;;
        2)
            validate_yaml
            ;;
        3)
            reload_dashy
            ;;
        4)
            add_service
            ;;
        5)
            less DASHY-ORGANIZATION.md
            ;;
        6)
            ${EDITOR:-nano} config/conf.yml
            echo -e "${GREEN}✓ Editor closed${NC}"
            ;;
        7)
            less config/conf.yml
            ;;
        8)
            echo -e "${BLUE}Available backups:${NC}"
            ls -la config/*.backup.* 2>/dev/null || echo "No backups found"
            echo ""
            read -p "Enter backup filename to restore (or 'cancel'): " backup_file
            if [[ $backup_file != "cancel" ]] && [[ -f "config/$backup_file" ]]; then
                cp "config/$backup_file" config/conf.yml
                echo -e "${GREEN}✓ Restored from $backup_file${NC}"
            fi
            ;;
        9)
            echo -e "${GREEN}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            ;;
    esac
done