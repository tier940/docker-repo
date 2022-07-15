FROM docker.io/alpine:3

RUN apk add curl bash git \
  && rm -Rf /var/cache/apk/* \
  && git clone https://github.com/tfutils/tfenv.git /opt/tfenv \
  && ln -s /opt/tfenv/bin/* /usr/local/bin \
  && echo 'PATH=$PATH:$HOME/.local/bin:$HOME/bin' >> /root/.bash_profile \
  && echo 'export PATH' >> /root/.bash_profile

RUN useradd app
USER app
EXPOSE 5000

WORKDIR /home/app
