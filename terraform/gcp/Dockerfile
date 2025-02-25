FROM --platform=$BUILDPLATFORM gcr.io/google.com/cloudsdktool/cloud-sdk:512.0.0-alpine

ARG TARGETOS TARGETARCH
ARG TFSEC_VERSION="1.28.11"
ARG TFLINT_VERSION="0.54.0"
LABEL maintainer="tier940"

RUN apk add curl bash git unzip \
    && rm -Rf /var/cache/apk/* \
    && curl -Ls -o tfsec https://github.com/tfsec/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-${TARGETOS}-${TARGETARCH} \
    && chmod +x tfsec && mv tfsec /usr/local/bin/ \
    && curl -Ls -o /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_${TARGETOS}_${TARGETARCH}.zip \
    && unzip /tmp/tflint.zip -d /tmp/ \
    && install -c -v /tmp/tflint /usr/local/bin/ \
    && rm /tmp/tflint*

USER cloudsdk
RUN git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv \
    && echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc \
    && echo 'export PS1="\e[0;32m\u@\h\e[1;37m:\e[0;34m\w\e[1;37m$ "' >> ~/.bashrc \
    && mkdir /home/cloudsdk/work

WORKDIR /home/cloudsdk/work
