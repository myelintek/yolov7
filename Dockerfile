FROM nvcr.io/nvidia/pytorch:24.02-py3

WORKDIR /mlsteam/lab

# ADD requirements.txt .
ADD . /mlsteam/lab
ADD https://ultralytics.com/assets/Arial.ttf /root/.config/Ultralytics/Arial.ttf

RUN sed -i 's/archive.ubuntu.com/tw.archive.ubuntu.com/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    htop \
    libgl1-mesa-glx \
    screen \
    zip \
  && apt-get clean && rm -rf /var/lib/apt/lists/* 

RUN pip3 install --no-cache seaborn thop

RUN pip3 install --no-cache -r requirements.txt && \
    pip uninstall -y opencv-python && \
    pip install --no-cache opencv-python-headless==4.5.5.64
