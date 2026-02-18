FROM golang:alpine AS builder
RUN apk update && apk add --no-cache 'git=~2'

ENV GO111MODULE=on
WORKDIR /app

COPY ./gin-backend-starter .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /main .

FROM alpine:3

WORKDIR /app

COPY --from=builder /main /app/main
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENV PORT=${PORT}
EXPOSE ${PORT}

ENTRYPOINT ["/app/entrypoint.sh"]
