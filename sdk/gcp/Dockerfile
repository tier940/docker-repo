FROM docker.io/google/cloud-sdk:alpine

RUN apk add curl bash git \
  && rm -Rf /var/cache/apk/* \
  && echo 'PATH=$PATH:$HOME/.local/bin:$HOME/bin' >> /root/.bash_profile \
  && echo 'export PATH' >> /root/.bash_profile \
  && echo 'PATH=$PATH:/root/google-cloud-sdk/bin' >> /root/.bash_profile

RUN useradd app
USER app
EXPOSE 5000

WORKDIR /home/app
