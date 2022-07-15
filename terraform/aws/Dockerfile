FROM docker.io/alpine:3

ARG AWS_VAULT_VERSION="6.6.0"
ARG AWS_IAM_AUTHENTICATOR="1.21.2/2021-07-05"

RUN apk add curl bash git \
&& rm -Rf /var/cache/apk/* \
&& wget -q -O /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 \
&& chmod +x /usr/local/bin/aws-vault \
&& git clone https://github.com/tfutils/tfenv.git /opt/tfenv \
&& ln -s /opt/tfenv/bin/* /usr/local/bin \
&& wget -q -O /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/${AWS_IAM_AUTHENTICATOR}/bin/linux/amd64/aws-iam-authenticator \
&& chmod +x /usr/local/bin/aws-iam-authenticator \
&& echo 'PATH=$PATH:$HOME/.local/bin:$HOME/bin' >> /root/.bash_profile \
&& echo 'export PATH' >> /root/.bash_profile \
&& echo 'export AWS_VAULT_BACKEND="file"' >> /root/.bashrc
