## normal usage
### One line command
- `cp -r ./squid.conf.opt ./squid.conf`
- `docker compose build; docker run --name squid -d --net=host squid-lxc:latest`

### docker compose
- `cp -r ./squid.conf.opt ./squid.conf`
- `docker compose up -d`



## ssl-bump
### 1. generate cert
- `openssl genrsa -out bump.key 4096`

### 2. generate csr
- `openssl req -new -key bump.key -out bump.csr​`

### 3. generate crt
- `openssl x509 -req -days 365 -in bump.csr -signkey bump.key -out bump.crt`

### 4. generate dhparam
- `openssl dhparam -outform PEM -out bump_dhparam.pem 2048`
