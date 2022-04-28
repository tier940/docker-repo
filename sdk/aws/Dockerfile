FROM amazon/aws-cli:2.0.60
LABEL maintainer="ReLightings <service@relightings.com>"
LABEL description="Include aws-vault on custom aws-cli image."

ARG AWS_VAULT_VERSION="6.2.0"

RUN yum install -y awscli git tar unzip vim > /dev/null && \
  yum clean all -y > /dev/null && \
  curl -s -o /usr/local/bin/aws-vault -L https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 && \
  chmod +x /usr/local/bin/aws-vault

RUN echo 'if [ -f /etc/bashrc ]; then' > /root/.bashrc && \
  echo '  . /etc/bashrc' >> /root/.bashrc && \
  echo 'fi' >> /root/.bashrc && \
  echo 'if [ -f ~/.bashrc ]; then' > /root/.bash_profile && \
  echo '  . ~/.bashrc' >> /root/.bash_profile && \
  echo 'fi' >> /root/.bash_profile && \
  echo 'PATH=$PATH:$HOME/.local/bin:$HOME/bin' >> /root/.bash_profile && \
  echo 'export PATH' >> /root/.bash_profile && \
  echo 'export AWS_VAULT_BACKEND="file"' >> /root/.bashrc
