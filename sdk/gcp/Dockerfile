FROM google/cloud-sdk:alpine
LABEL maintainer="ReLightings"
LABEL description=""

RUN apk add curl bash git \
  && rm -Rf /var/cache/apk/* \
  && echo 'if [ -f /etc/bashrc ]; then' > /root/.bashrc \
  && echo '  . /etc/bashrc' >> /root/.bashrc \
  && echo 'fi' >> /root/.bashrc \
  && echo 'if [ -f ~/.bashrc ]; then' > /root/.bash_profile \
  && echo '  . ~/.bashrc' >> /root/.bash_profile \
  && echo 'fi' >> /root/.bash_profile \
  && echo 'PATH=$PATH:$HOME/.local/bin:$HOME/bin' >> /root/.bash_profile \
  && echo 'export PATH' >> /root/.bash_profile \
  && echo 'PATH=$PATH:/root/google-cloud-sdk/bin' >> /root/.bash_profile

RUN useradd app
USER app
EXPOSE 5000

WORKDIR /home/app
