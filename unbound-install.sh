#!/bin/bash
#
# @author: Pedro Soares - Fastrouter
# @contact: fastrouterconsult@gmail.com
#
# Script de instalacao para DNS Resolver recursivo com Unbound
#

echo ""
echo "-------------------------------------------------------------"
echo ""
echo "####  Script install for UNBOUND  - Default Fastrouter   ####"
echo ""
echo "-------------------------------------------------------------"
echo ""
echo "Info the is you server"
read -p 'IP SERVER:......' IPDNS
read -p 'BLOCO IPV4:.....' IPV4
read -p 'BLOCO IPV6:.....' IPV6
echo ""
read -n1 -r -p "Press any key to confirme..."

# Install Unbound
echo ""
echo "Start update......"
apt update -qq
echo ""
echo "Update OK!"
echo ""

# Install Unbound e packages
echo "Install Unbound......"
apt install unbound dnsutils wget -y -qq 2>/dev/null >/dev/null;
echo "OK!"
echo ""

# Get root servers list
echo "Download named.cache......"
wget /etc/unbound/root.hints https://www.internic.net/domain/named.cache -q
echo "OK!"
echo ""

# Configuration
echo "Configuring Unbound......"
cd /etc/unbound/unbound.conf.d/
rm root-auto-trust-anchor-file.conf
wget https://fastrouter.com.br/scripts/root-auto-trust-anchor-file.conf -q
sed -i "s|10.8.8.8|$IPDNS|" root-auto-trust-anchor-file.conf
sed -i "s|200.200.200.0/22|$IPV4|" root-auto-trust-anchor-file.conf
sed -i "s|2001:DB8::/32|$IPV6|" root-auto-trust-anchor-file.conf
echo "OK!"
echo ""

# Service Restar
echo "Starting service......"
systemctl is-enabled unbound > /dev/null;
systemctl restart unbound
echo "OK!"
echo ""

# Disable previous DNS servers
echo "Change resolv.conf......"
sed -i "s|nameserver|#nameserver|" /etc/resolv.conf
sed -i "s|search|#search|" /etc/resolv.conf
echo "nameserver 127.0.0.1" >> /etc/resolv.conf
echo "OK!"
echo ""

# Verifica estado do servico
echo "Service status......"
echo "------------------------------------------------------------"
service unbound status | grep -e Active -e Memory -e CPU 
echo "------------------------------------------------------------"
echo ""
echo "The installation is done!!!"
echo ""
