FROM alpine:latest
MAINTAINER "Casper Skydt <Casper@Skydt.Org>"

ENV TERRAFORM_VERSION=0.8.4
ENV TERRAFORM_SHA256SUM=4e1f5ec48c943969a2989f2b8060cd2065cc6d7e1987c0d01875ecbd219b98a3

RUN apk add --update git bash wget

ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS ./

RUN sed -i '/terraform_${TERRAFORM_VERSION}_linux_amd64.zip/!d' terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip