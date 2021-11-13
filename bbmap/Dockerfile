FROM ubuntu:20.04

SHELL [ "/bin/bash", "--login", "-c" ]

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qqy \
    && apt-get install -qqy \
        apt-utils \
        wget \
        vim \
        sudo \
        build-essential

ARG MINICONDA_VERSION=latest
ARG USER=galaxy

RUN groupadd ${USER} \
    && useradd -m -g ${USER} ${USER} -d /home/${USER} -s /bin/bash -p "$(openssl passwd -1 galaxy)" \
    && usermod -aG sudo galaxy

WORKDIR /home/${USER}

USER ${USER}

RUN cd /tmp \
    && wget --quiet https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh \
    && bash Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p /home/${USER}/.conda \
    && rm Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh 

ENV PATH /home/${USER}/.conda/bin:$PATH
COPY requirements.yml /tmp/requirements.yml
COPY bbmap_script_updated_v1_13112021.sh /home/${USER}/.conda/bin/bbmap_script_updated.sh
USER root
RUN chmod +x /home/${USER}/.conda/bin/bbmap_script_updated.sh
USER ${USER}
RUN conda env create -n "bbmap" -f /tmp/requirements.yml
RUN echo "source activate bbmap" > ~/.bashrc
ENV PATH /home/${USER}/.conda/envs/bbmap/bin:$PATH
RUN /bin/bash -c "source activate bbmap"
RUN echo $PATH

