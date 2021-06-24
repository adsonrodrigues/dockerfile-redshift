FROM ubuntu:20.04

WORKDIR /usr/local/app

ENV DEBIAN_FRONTEND noninteractive
ENV LIBEV_FLAGS=4

RUN apt update -y
RUN apt upgrate -y

RUN apt-get update --fix-missing

RUN apt-get install -y \
    python3 python3-dev python3-pip python3-virtualenv python3-setuptools \
    wget

RUN wget https://s3.amazonaws.com/redshift-downloads/drivers/odbc/1.4.27.1000/AmazonRedshiftODBC-64-bit-1.4.27.1000-1.x86_64.deb
RUN dpkg -i AmazonRedshiftODBC-64-bit-1.4.27.1000-1.x86_64.deb

RUN echo "alias python=python3" >> ~/.bash_aliases
RUN echo "alias pip=pip3" >> ~/.bash_aliases

COPY ./requirements.txt .
RUN pip3 install -r requirements.txt

COPY . .

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TERM screen