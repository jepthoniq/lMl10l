FROM debian:11
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install \
    python3 python3-dev python3-dev python3-pip python3-venv 

RUN apt-get install git curl python3-pip ffmpeg -y
RUN apt-get install git curl python3-pip mediainfo -y
RUN apt-get install git curl python3-pip p7zip-full -y
RUN pip3 install pillow \
    google_trans_new \
    googletrans==4.0.0rc1
RUN apt-get update \
    && apt-get install -y unzip wget
ARG USER=root
USER $USER
RUN python3 -m venv venv
WORKDIR /app
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
COPY requirements.txt ./requirements.txt
RUN pip3 install -r requirements.txt
COPY start start
COPY app.py app.py
EXPOSE 5000
RUN chmod +x /app/start
ENTRYPOINT ["./start"]
