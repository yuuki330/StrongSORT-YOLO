FROM python:3.8.6-slim

RUN apt update && apt upgrade -y

ENV TZ=Asia/Tokyo

ARG req_txt="requirements.txt"
COPY ./${req_txt} /workspace/

# tzdataの設定を自動化するためにDEBIAN_FRONTENDをnoninteractiveに設定
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
# タイムゾーンの設定
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update
RUN apt-get install -y python3-dev 

RUN apt install -y \
    cmake \
    build-essential \
    git \
    curl \
    libgl1-mesa-glx \
    libglib2.0-0

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py

RUN python3 -m pip install --no-cache-dir -r workspace/${req_txt}