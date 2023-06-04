FROM ubuntu:focal AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential sudo && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS guven
ARG TAGS
RUN adduser --disabled-password --gecos 'guventemiz' guventemiz   
RUN adduser guventemiz sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER guventemiz
RUN mkdir /home/guventemiz/ansible
WORKDIR /home/guventemiz/ansible

FROM guven
COPY --chown=guventemiz:guventemiz . .
CMD ["bash"]
#CMD ["sh", "-c", "ansible-playbook --ask-vault-pass $TAGS local.yml"]

