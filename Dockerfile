FROM golang:1.13

RUN apt-get update && \
 apt-get install -y unzip zsh make cmake wget python3 curl python3-pip && \
 curl -sL https://deb.nodesource.com/setup_10.x && \
 apt-get install -y nodejs build-essential && \
 apt-get clean

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --upgrade pip && pip3 install -r /tmp/requirements.txt

ENV TERRAFORM_VERSION=0.12.21
RUN wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip /tmp/terraform.zip -d /tmp && \
  mv /tmp/terraform /usr/local/bin/ && \
  rm -r /tmp/terraform*

# Terraform-docs
ENV TERRAFORM_DOCS_VERSION=0.6.0
RUN wget -O /tmp/terraform-docs https://github.com/segmentio/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64 && \
  mv /tmp/terraform-docs /usr/local/bin/terraform-docs && \
  chmod 755 /usr/local/bin/terraform-docs

WORKDIR /usr/local/src