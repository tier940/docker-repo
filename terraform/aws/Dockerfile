FROM --platform=$BUILDPLATFORM public.ecr.aws/aws-cli/aws-cli:2.15.9

ARG TARGETOS TARGETARCH
ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
ARG AWS_VAULT_VERSION="7.2.0"
ARG TFSEC_VERSION="1.28.4"
ARG TFLINT_VERSION="0.49.0"
LABEL maintainer="tier940"

RUN yum install -y shadow-utils tzdata git tar unzip > /dev/null \
    && yum clean all -y > /dev/null \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && curl -Ls -o /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-${TARGETOS}-${TARGETARCH} \
    && chmod +x /usr/local/bin/aws-vault \
    && groupadd -g ${GID} ${GROUPNAME} \
    && useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USERNAME} \
    && curl -Ls -o tfsec https://github.com/tfsec/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-${TARGETOS}-${TARGETARCH} \
    && chmod +x tfsec && mv tfsec /usr/local/bin/ \
    && curl -Ls -o /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_${TARGETOS}_${TARGETARCH}.zip \
    && unzip /tmp/tflint.zip -d /tmp/ \
    && install -c -v /tmp/tflint /usr/local/bin/ \
    && rm /tmp/tflint*

USER ${USERNAME}
RUN git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv \
    && echo 'export AWS_VAULT_BACKEND="file"' >> ~/.bashrc \
    && echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc \
    && echo 'export PS1="\e[0;32m\u@\h\e[1;37m:\e[0;34m\w\e[1;37m$ "' >> ~/.bashrc \
    && mkdir /home/${USERNAME}/work

WORKDIR /home/${USERNAME}/work

ENTRYPOINT ["/bin/bash"]
