FROM docker.io/amazon/aws-cli:2.11.0

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
ARG AWS_VAULT_VERSION="7.0.1"
ARG AWS_IAM_AUTHENTICATOR_VERSION="0.5.9"

RUN yum install -y shadow-utils git tar unzip vim > /dev/null \
  && yum clean all -y > /dev/null \
  && curl -Ls -o /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 \
  && chmod +x /usr/local/bin/aws-vault \
  && curl -Ls -o /usr/local/bin/aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${AWS_IAM_AUTHENTICATOR_VERSION}/aws-iam-authenticator_${AWS_IAM_AUTHENTICATOR_VERSION}_linux_amd64 \
  && chmod +x /usr/local/bin/aws-iam-authenticator \
  && groupadd -g ${GID} ${GROUPNAME} \
  && useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USERNAME}

USER ${USERNAME}
RUN git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv \
  && echo 'export AWS_VAULT_BACKEND="file"' >> ~/.bashrc \
  && echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc \
  && echo 'export PS1="\e[0;32m\u@\h\e[1;37m:\e[0;34m\w\e[1;37m$ "' >> ~/.bashrc \
  && mkdir /home/${USERNAME}/work

WORKDIR /home/${USERNAME}/work
