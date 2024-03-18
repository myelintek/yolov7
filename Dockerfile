FROM nvcr.io/nvidia/pytorch:21.08-py3

ENV SHELL /bin/bash
ENV PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /mlsteam/lab

ADD clean-layer.sh requirements.txt requirements.system install-sshd.sh set_terminal_dark.sh get_coco128.sh /tmp/

RUN sed -i 's/archive.ubuntu.com/tw.archive.ubuntu.com/g' /etc/apt/sources.list && \
    mkdir -p /mlsteam/data && \
    mkdir -p /mlsteam/lab && \
    apt-get update && \
    xargs apt-get install -y < /tmp/requirements.system && \
    pip install --no-cache-dir --use-feature=2020-resolver -r /tmp/requirements.txt && \
    bash /tmp/install-sshd.sh && \
    bash /tmp/set_terminal_dark.sh && \
    bash /tmp/clean-layer.sh && \
    bash /tmp/get_coco128.sh

ADD ./src /mlsteam/lab
ADD ./requirements.txt /mlsteam/lab

RUN rm -rf /usr/lib/x86_64-linux-gnu/libcuda.so /usr/lib/x86_64-linux-gnu/libcuda.so.1 /tmp/*
