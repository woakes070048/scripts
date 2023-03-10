#!/bin/bash

echo "      ___         ___           ___           ___           ___           ___     "
echo "     /  /\       /__/\         /__/\         /  /\         /__/\         /  /\    "
echo "    /  /:/_      \  \:\        \  \:\       /  /:/_        \  \:\       /  /::\   "
echo "   /  /:/ /\      \__\:\        \__\:\     /  /:/ /\        \  \:\     /  /:/\:\  "
echo "  /  /:/ /::\ ___ /  /::\ ___   /  /::\   /  /:/_/::\   _____\__\:\   /  /:/~/::\ "
echo " /__/:/ /:/\:/__/\  /:/\:/__/\ /__/:/\:\ /__/:/__\/\:\ /__/::::::::\ /__/:/ /:/\:|"
echo " \  \:\/:/~/:/\:\ \/__\:\/:/\:\ \__\/  \:\ \  \:\ /:/\:\ \  \:\~~\~~\/ \  \:\/:/~/:/"
echo "  \  \::/ /:/__\/      \::/  \:\   /  /:/  \  \:\/:/__\/  \  \:\  ~~~   \  \::/ /:/ "
echo "   \  \:\/:/           /:/  /:/  /__/:/    \  \::/        \  \:\        \__\/ /:/  "
echo "    \  \::/           /:/  /:/   \__\/      \__\/          \  \:\         /__/:/   "
echo "     \__\/           /__/:/                                 \__\/         \__\/    "
echo "                    \__\/                                                            "
echo ""
echo "Installation script for n8n by Pegas Technology Solutions"
echo "This script will install Docker and all prerequisites for n8n installation"

# Check if domain name is set up
read -p "Have you set up your domain name automate.yourdomainname.com? (y/n) " domain
if [ "$domain" != "y" ]; then
  echo "Please set up your domain name and re-run the script"
  exit 1
fi
# Update and install Docker
sudo apt-get update
sudo apt-get install -y docker.io

# Install Docker Compose
sudo apt-get install -y docker-compose

# Clone n8n-docker repository
sudo git clone https://github.com/woakes070048/n8n-docker.git /opt/n8n-docker

# Set DATA_FOLDER to /opt/n8n-docker/data
sudo sed -i 's|DATA_FOLDER=.*|DATA_FOLDER=/opt/n8n-docker/data|' /opt/n8n-docker/docker-compose.yml

# Set domain name
sudo sed -i "s|SUB_DOMAIN=.*|SUB_DOMAIN=automate|; s|DOMAIN_NAME=.*|DOMAIN_NAME=yourdomainname.com|" /opt/n8n-docker/docker-compose.yml

# Set SSL_EMAIL to your email
sudo sed -i 's|SSL_EMAIL=.*|SSL_EMAIL=youremail@yourdomainname.com|' /opt/n8n-docker/docker-compose.yml

# Set POSTGRES_USER, POSTGRES_PASSWORD, and POSTGRES_DB
sudo sed -i 's|POSTGRES_USER=.*|POSTGRES_USER=n8nuser|; s|POSTGRES_PASSWORD=.*|POSTGRES_PASSWORD=n8npass|; s|POSTGRES_DB=.*|POSTGRES_DB=n8ndb|' /opt/n8n-docker/docker-compose.yml

# Set POSTGRES_NON_ROOT_USER and POSTGRES_NON_ROOT_PASSWORD
sudo sed -i 's|POSTGRES_NON_ROOT_USER=.*|POSTGRES_NON_ROOT_USER=n8nuser|; s|POSTGRES_NON_ROOT_PASSWORD=.*|POSTGRES_NON_ROOT_PASSWORD=n8npass|' /opt/n8n-docker/docker-compose.yml

# Set N8N_EMAIL_MODE, N8N_SMTP_HOST, N8N_SMTP_PORT, N8N_SMTP_SSL, N8N_SMTP_USER, N8N_SMTP_PASS, and N8N_SMTP_SENDER
sudo sed -i 's|N8N_EMAIL_MODE=.*|N8N_EMAIL_MODE=smtp|; s|N8N_SMTP_HOST=.*|N8N_SMTP_HOST=smtp.mailersend.net|; s|N8N_SMTP_PORT=.*|N8N_SMTP_PORT=587|; s|N8N_SMTP_SSL=.*|N8N_SMTP_SSL=false|; s|N8N_SMTP_USER=.*|N8N_SMTP_USER=user-from-mailersend@yourdomainname.com|; s|N8N_SMTP_PASS=.*|N8N_SMTP_PASS=pass-from-mailersend|; s|N8N_SMTP_SENDER=.*|N8N_SMTP_SENDER=n8n@yourdomainname.com|' /opt/n8n-docker/docker-compose.yml

echo "Installation complete Have Fun Automating"
echo "Please make sure you have support for your server contact at support@pegas.io or fill out our contact from at https://pegas.io/contact/"
