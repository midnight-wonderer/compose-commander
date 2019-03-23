FROM python:3

RUN apt-get update -qq

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

RUN apt-get install -y build-essential nano ssh sshpass
RUN pip install ansible

RUN useradd -ms /bin/bash runner
USER runner

ENV HOME=/home/runner
ENV LANG=C.UTF-8
ENV ANSIBLE_HOME=$HOME/ansible
RUN mkdir -p $ANSIBLE_HOME
WORKDIR $ANSIBLE_HOME
