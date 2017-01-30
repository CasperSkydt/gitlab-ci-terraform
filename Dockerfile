FROM alpine:latest
MAINTAINER "Casper Skydt <Casper@Skydt.Org>"

ENV TERRAFORM_VERSION=0.8.5
ENV TERRAFORM_SHA256SUM=4b4324e354c26257f0b830eacb0e7cc7e2ced017d78855f74cb9377f1abf1dd7

RUN apk add --update git bash wget jq

ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS ./

RUN sed -i '/terraform_${TERRAFORM_VERSION}_linux_amd64.zip/!d' terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip
