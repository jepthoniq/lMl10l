FROM nikolaik/python-nodejs:python3.10-nodejs18
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ffmpeg \
    && apt-get install -y --no-install-recommends mediainfo \
    && apt-get install -y --no-install-recommends p7zip-full \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install pillow \
    google_trans_new \
    googletrans==4.0.0rc1
RUN apt-get update \
    && apt-get install -y unzip wget
COPY . /app/
WORKDIR /app/
COPY app.py app.py
EXPOSE 5000
RUN chmod +x /app/start
RUN pip3 install --upgrade pip
RUN pip3 install -U pip && pip3 install -U -r requirements.txt
CMD ["bash", "start"]
