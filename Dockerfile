FROM python:3.8-alpine
ADD src/requirements.txt /home/
ADD atom/id_rsa /root/
ENV GIT_SSH_COMMAND='ssh -i /root/id_rsa -o "StrictHostKeyChecking=no"'
RUN cd /home &&\
    apk add --no-cache --virtual .build-deps gcc musl-dev linux-headers python-dev &&\
    pip install -r requirements.txt &&\
    apk del --no-network .build-deps &&\
    apk add git openssh-client
RUN chmod 600 /root/id_rsa && mkdir -p /opt/tower/data
ADD src/ /home/
WORKDIR /home
EXPOSE 5000
#ENTRYPOINT ["python"]
