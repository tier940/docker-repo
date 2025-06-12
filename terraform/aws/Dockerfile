FROM --platform=$BUILDPLATFORM public.ecr.aws/aws-cli/aws-cli:2.27.34 AS builder

ARG TARGETOS TARGETARCH
ARG AWS_VAULT_VERSION="7.2.0"
ARG TFSEC_VERSION="1.28.14"
ARG TFLINT_VERSION="0.58.0"
ARG TFV_VERSION="0.2.1"

RUN yum install -y shadow-utils tzdata git tar unzip curl > /dev/null \
    && yum clean all -y > /dev/null

# Install aws-vault
RUN curl -Ls -o /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-${TARGETOS}-${TARGETARCH} \
    && chmod +x /usr/local/bin/aws-vault

# Install tfsec
RUN curl -Ls -o /usr/local/bin/tfsec https://github.com/tfsec/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-${TARGETOS}-${TARGETARCH} \
    && chmod +x /usr/local/bin/tfsec

# Install tflint
RUN curl -Ls -o /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_${TARGETOS}_${TARGETARCH}.zip \
    && unzip /tmp/tflint.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/tflint \
    && rm -f /tmp/tflint.zip

# tfversion
RUN curl -Ls -o /tmp/tfversion.tar.gz https://github.com/tfversion/tfversion/releases/download/v${TFV_VERSION}/tfversion_${TFV_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz \
    && tar -xzf /tmp/tfversion.tar.gz -C /usr/local/bin/ \
    && chmod +x /usr/local/bin/tfversion \
    && rm -f /tmp/tfversion.tar.gz


########################################
# Final Build Stage
########################################
FROM --platform=$BUILDPLATFORM public.ecr.aws/aws-cli/aws-cli:2.27.34

ARG USERNAME=ec2-user
ARG GROUPNAME=ec2-user
ARG UID=1000
ARG GID=1000
LABEL maintainer="tier940"

COPY --from=builder /usr/local/bin/aws-vault /usr/local/bin/aws-vault
COPY --from=builder /usr/local/bin/tfsec /usr/local/bin/tfsec
COPY --from=builder /usr/local/bin/tflint /usr/local/bin/tflint
COPY --from=builder /usr/local/bin/tfversion /usr/local/bin/tfversion

RUN yum install -y shadow-utils tzdata git > /dev/null \
    && yum clean all -y > /dev/null \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && groupadd -g ${GID} ${GROUPNAME} \
    && useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USERNAME}

RUN mkdir -p /home/${USERNAME}/.tfversion/bin \
    && chown ${USERNAME}:${USERNAME} -R /home/${USERNAME}/.tfversion/

USER ${USERNAME}
RUN echo 'export AWS_VAULT_BACKEND="file"' >> ~/.bashrc \
    && echo 'export PATH=$PATH:$HOME/.tfversion/bin:$PATH' >> ~/.bashrc \
    && echo 'export PS1="\e[0;32m\u@\h\e[1;37m:\e[0;34m\w\e[1;37m$ "' >> ~/.bashrc \
    && mkdir -p /home/${USERNAME}/work

WORKDIR /home/${USERNAME}/work
ENTRYPOINT ["/bin/bash"]
