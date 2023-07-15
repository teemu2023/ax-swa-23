FROM golang:1.16

WORKDIR /app

ADD . /app

RUN go build -o /roll-backend

EXPOSE 9300

CMD [ "/roll-backend" ]
