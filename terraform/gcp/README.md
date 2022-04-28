# gcp
## docker-compose.yml
```
version: '3'
services:
  terraform:
    image: registry.gitlab.com/relightings/public/tools/docker/terraform/gcp:latest
    entrypoint: ['/bin/bash']
    container_name: terraform
    tty: true
    volumes:
      - ./share:/mnt
```

## command
```
docker-compose up -d
docker-compose exec terraform /bin/bash
```
