FROM alpine:3
LABEL maintainer="ReLightings <service@relightings.com>"
LABEL description="Include aws-vault on terraform."

ARG AWS_VAULT_VERSION="6.2.0"
ARG AWS_IAM_AUTHENTICATOR="1.18.8/2020-09-18"

RUN apk add curl bash git \
&& rm -Rf /var/cache/apk/* \
&& wget -q -O /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 \
&& chmod +x /usr/local/bin/aws-vault \
&& git clone https://github.com/tfutils/tfenv.git /opt/tfenv \
&& ln -s /opt/tfenv/bin/* /usr/local/bin \
&& wget -q -O /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/${AWS_IAM_AUTHENTICATOR}/bin/linux/amd64/aws-iam-authenticator \
&& chmod +x /usr/local/bin/aws-iam-authenticator \
&& echo 'if [ -f /etc/bashrc ]; then' > /root/.bashrc \
&& echo '  . /etc/bashrc' >> /root/.bashrc \
&& echo 'fi' >> /root/.bashrc \
&& echo 'if [ -f ~/.bashrc ]; then' > /root/.bash_profile \
&& echo '  . ~/.bashrc' >> /root/.bash_profile \
&& echo 'fi' >> /root/.bash_profile \
&& echo 'PATH=$PATH:$HOME/.local/bin:$HOME/bin' >> /root/.bash_profile \
&& echo 'export PATH' >> /root/.bash_profile \
&& echo 'export AWS_VAULT_BACKEND="file"' >> /root/.bashrc
