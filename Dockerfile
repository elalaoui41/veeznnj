# FROM  debian:buster
# ADD ./src /app

# RUN  apt update -y

# RUN  apt install python3-pip -y
# RUN apt-get update && apt-get install -y python3-opencv
# RUN python3 -m pip install --upgrade pip

# RUN pip3 install -r /app/requirements.txt

# CMD [ "sh", "/app/start.sh" ,"--browser.serverAddress", "0.0.0.0" ]

FROM python:3.7

COPY ./src/requirements.txt /app/requirements.txt
WORKDIR /app
RUN apt-get update -y && \
    apt-get install build-essential cmake pkg-config -y
RUN pip install pymongo
RUN pip install dlib==19.9.0
RUN apt-get install -y python3-opencv
RUN pip install -r /app/requirements.txt
ADD ./src /app

EXPOSE 8501
ENTRYPOINT ["streamlit", "run"]

CMD ["app.py", "--browser.serverAddress=localhost","--server.baseUrlPath=stream"]
# , "--server.enableXsrfProtection=false",  "--server.enableWebsocketCompression=false", " --server.enableCORS false", "--browser.serverAddress=0.0.0.0" ]