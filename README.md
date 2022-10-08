# DNS Recursivo com Unbound

## Requisitos mínimos de Hardware

* CPU: 4 Core
* MEM: 4Gb
* DISCO: 50Gb
* REDE: 1Gbps
* Instalação Debian com recursos mínimos e acesso SSH.

## Instalação

Realizar instalação dos pacotes unbound e de verificações de DNS.

```
apt update && apt upgrade

apt install unbound bind9-dnsutils git
```

Acessar pasta do unbound e baixar arquivo de configuração

```
cd /etc/unbound/unbound.conf.d/

git clone https://github.com/fastrouter/dns/root-auto-trust-anchor-file.conf

```

Editar arquivo root-auto-trust-anchor-file.conf com os ips conforme sua rede e reiniciar serviço do ubbound

```
systemctl enable unbound
systemctl restart unbound

```





