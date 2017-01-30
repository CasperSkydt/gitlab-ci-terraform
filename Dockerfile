FROM alpine:latest
MAINTAINER "Casper Skydt <Casper@Skydt.Org>"

ENV TERRAFORM_VERSION=0.8.4
ENV TERRAFORM_SHA256SUM=297d35d0b4311445cd87ef032d3dec917bcc7a8b163ead28a4c45d966a2f75cc

RUN apk add --update git bash wget jq
RUN wget "s3.amazonaws.com/aws-cli/awscli-bundle.zip" -O "awscli-bundle.zip" && unzip awscli-bundle.zip && apk add --update groff less python && rm /var/cache/apk/* && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws &&  rm awscli-bundle.zip && rm -rf awscli-bundle
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS ./

RUN sed -i '/terraform_${TERRAFORM_VERSION}_linux_amd64.zip/!d' terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
