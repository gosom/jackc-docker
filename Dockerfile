FROM golang:1.18.3-alpine as builder

LABEL maintainer="Georgios Komninos"
LABEL website="https://blog.gkomninos.com"

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

WORKDIR /app

RUN go install github.com/jackc/tern@latest

FROM alpine:latest  

RUN apk --no-cache add ca-certificates

WORKDIR /usr/bin

COPY --from=builder /go/bin .

ENTRYPOINT ["/usr/bin/tern"]
