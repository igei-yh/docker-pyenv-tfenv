# dockerfile for deploy by terraform in docker ci environment.

FROM ubuntu:latest
MAINTAINER techonoarc

# set environment
ENV TERRAFORM_VERSION=0.11.7
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
ENV TERRAFORM_DIR=infrastructure/projects
ENV PYTHON_VERSION=3.6.0
ENV HOME=/root

# install common packages
RUN apt-get update && \
    apt-get -y install unzip curl
RUN apt-get -y install git make build-essential python-dev python-pip libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev

# install terraform via tfenv
RUN git clone https://github.com/kamatama41/tfenv.git ~/.tfenv

ENV PATH $HOME/.tfenv/bin:$PATH

RUN tfenv install ${TERRAFORM_VERSION}
RUN terraform version

# install python via pyenv
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv

ENV PYENV_ROOT=$HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN pyenv install ${PYTHON_VERSION}
RUN pyenv global ${PYTHON_VERSION}
RUN python --version
