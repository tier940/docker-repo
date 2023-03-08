FROM docker.io/google/cloud-sdk:alpine

RUN apk add curl bash git \
  && rm -Rf /var/cache/apk/*

USER cloudsdk
RUN git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv \
  && echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc \
  && echo 'export PS1="\e[0;32m\u@\h\e[1;37m:\e[0;34m\w\e[1;37m$ "' >> ~/.bashrc \
  && mkdir /home/cloudsdk/work

WORKDIR /home/cloudsdk/work
