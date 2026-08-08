Based on Alpine 3.24 with squid 7.6.

## normal usage
### One line command
- `cp -r ./squid.conf.opt ./squid.conf`
- `docker compose build; docker run --name squid -d --net=host squid-lxc:latest`

### docker compose
- `cp -r ./squid.conf.opt ./squid.conf`
- `docker compose up -d`

### Upgrading from squid 6
`compose.yml` mounts your own `./squid.conf` over the one baked into the image,
so updating the image alone does not update your config. Re-copy it:

- `cp -r ./squid.conf.opt ./squid.conf`

squid 7 rejects two directives the old config carried. If you keep a
hand-edited `squid.conf`, drop them yourself:

- `cache_dir null /tmp` — the null store was removed. Caching is already off via
  `cache deny all` and `cache_mem 0 MB`, so just delete the line.
- `acl localhost src 127.0.0.1/32 ::1` — `localhost` is now a built-in ACL and
  redeclaring it warns on every start.



## ssl-bump
### 1. generate cert
- `openssl genrsa -out bump.key 4096`

### 2. generate csr
- `openssl req -new -key bump.key -out bump.csr​`

### 3. generate crt
- `openssl x509 -req -days 365 -in bump.csr -signkey bump.key -out bump.crt`

### 4. generate dhparam
- `openssl dhparam -outform PEM -out bump_dhparam.pem 2048`
