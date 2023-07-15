FROM golang:1.16

WORKDIR /app

ADD . /app

RUN go build -o /roll-frontend

EXPOSE 9301

CMD [ "/roll-frontend" ]
