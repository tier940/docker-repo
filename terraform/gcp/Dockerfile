FROM --platform=$BUILDPLATFORM gcr.io/google.com/cloudsdktool/cloud-sdk:523.0.1-slim AS builder

ARG TARGETOS
ARG TARGETARCH
ARG TFSEC_VERSION="1.28.14"
ARG TFLINT_VERSION="0.58.0"
ARG TFV_VERSION="0.2.1"

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends unzip curl \
    && rm -rf /var/lib/apt/lists/*

# Install tfsec
RUN curl -Ls -o /usr/local/bin/tfsec https://github.com/tfsec/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-${TARGETOS}-${TARGETARCH} \
    && chmod +x /usr/local/bin/tfsec

# Install tflint
RUN curl -Ls -o /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_${TARGETOS}_${TARGETARCH}.zip \
    && unzip /tmp/tflint.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/tflint \
    && rm -f /tmp/tflint.zip

# Install tfversion
RUN curl -Ls -o /tmp/tfversion.tar.gz https://github.com/tfversion/tfversion/releases/download/v${TFV_VERSION}/tfversion_${TFV_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz \
    && tar -xzf /tmp/tfversion.tar.gz -C /usr/local/bin/ \
    && chmod +x /usr/local/bin/tfversion \
    && rm -f /tmp/tfversion.tar.gz


########################################
# Final Build Stage
########################################
FROM gcr.io/google.com/cloudsdktool/cloud-sdk:523.0.1-slim

COPY --from=builder /usr/local/bin/tfsec /usr/local/bin/tfsec
COPY --from=builder /usr/local/bin/tflint /usr/local/bin/tflint
COPY --from=builder /usr/local/bin/tfversion /usr/local/bin/tfversion

RUN mkdir -p /home/cloudsdk/.tfversion/bin \
    && chown cloudsdk:cloudsdk -R /home/cloudsdk/.tfversion/

USER cloudsdk
RUN echo 'export PATH=$PATH:$HOME/.tfversion/bin:$PATH' >> ~/.bashrc \
    && echo 'export PS1="\e[0;32m\u@\h\e[1;37m:\e[0;34m\w\e[1;37m$ "' >> ~/.bashrc \
    && mkdir -p /home/cloudsdk/work

WORKDIR /home/cloudsdk/work
