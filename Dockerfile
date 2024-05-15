FROM ubuntu:22.04

USER root

ENV DEBIAN_FRONTEND noninteractive

## INSTALL R
RUN apt update -y \
    && apt upgrade -y \
    && apt install -y \
    software-properties-common \
    dirmngr \
    gnupg2 \
    wget

RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
    | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc \
    && add-apt-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
    && apt-get update -y \
    && apt-get install -y r-base


# Install RStudio Server for Ubuntu 22.04
RUN wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2023.09.0-463-amd64.deb && \
    apt-get install -y gdebi-core && \
    gdebi -n rstudio-server-2023.09.0-463-amd64.deb && \
    rm rstudio-server-2023.09.0-463-amd64.deb

EXPOSE 8787


RUN useradd -m -s /bin/bash -d /home/rstudio rstudio && \
    echo "rstudio:rstudio" | chpasswd && adduser rstudio sudo

# install python
RUN apt-get install -y python3 python3-pip python3-dev python3-venv 


# # Install Python packages
WORKDIR /workspace


COPY requirements.txt /workspace/
RUN pip3 install --no-cache-dir -r requirements.txt

COPY install_packages.R /workspace/
RUN Rscript install_packages.R


CMD /usr/lib/rstudio-server/bin/rserver --server-daemonize=0