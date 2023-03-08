FROM docker.io/google/cloud-sdk:alpine

RUN apk add curl bash git \
  && rm -Rf /var/cache/apk/* \
  && git clone https://github.com/tfutils/tfenv.git /opt/tfenv \
  && ln -s /opt/tfenv/bin/* /usr/local/bin

USER cloudsdk
RUN echo 'PATH=$PATH:$HOME/.local/bin:$HOME/bin' >> ~/.bash_profile \
  && echo 'export PATH' >> ~/.bash_profile \
  && echo 'export AWS_VAULT_BACKEND="file"' >> ~/.bashrc \
  && echo 'export PS1="\e[0;32m\u@\h\e[1;37m:\e[0;34m\w\e[1;37m$ "' >> ~/.bashrc \
  && mkdir /home/cloudsdk/work

WORKDIR /home/cloudsdk/work
