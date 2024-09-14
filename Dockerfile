#FROM alpine:3.20

#ARG TARGETOS
#ARG TARGETARCH
#ARG TARGETVARIANT

#WORKDIR /app
#COPY build/glance-$TARGETOS-$TARGETARCH${TARGETVARIANT} /app/glance

#EXPOSE 8080/tcp
#ENTRYPOINT ["/app/glance"]

FROM golang:1.22.5-alpine3.20 AS builder

WORKDIR /app
COPY . /app
RUN CGO_ENABLED=0 go build .

FROM alpine:3.20

WORKDIR /app
COPY --from=builder /app/glance .

EXPOSE 8080/tcp
ENTRYPOINT ["/app/glance"]
