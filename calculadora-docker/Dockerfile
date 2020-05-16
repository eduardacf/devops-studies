FROM golang:1.12.6
MAINTAINER Eduarda Correia Ferreira "eduarda.ferreira@ilegra.com"
EXPOSE 8080
RUN go get -u github.com/gorilla/mux
WORKDIR /tema-07/
COPY ./calculadora.go /tema-07
CMD ["go", "run", "calculadora.go"]
