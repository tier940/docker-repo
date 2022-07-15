FROM docker.io/amazon/aws-cli:2.7.15
LABEL description="Include aws-vault on custom aws-cli image."

ARG AWS_VAULT_VERSION="6.6.0"

RUN yum install -y awscli git tar unzip vim > /dev/null && \
  yum clean all -y > /dev/null && \
  curl -s -o /usr/local/bin/aws-vault -L https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 && \
  chmod +x /usr/local/bin/aws-vault && \
  'PATH=$PATH:$HOME/.local/bin:$HOME/bin' >> /root/.bash_profile && \
  echo 'export PATH' >> /root/.bash_profile && \
  echo 'export AWS_VAULT_BACKEND="file"' >> /root/.bashrc
