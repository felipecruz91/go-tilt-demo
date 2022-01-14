# Start by building the application.
FROM golang:1.17-bullseye as build

WORKDIR /go/src/app

COPY go.* .
RUN go mod download

COPY . /go/src/app
RUN CGO_ENABLED=0 go build -o /go/bin/app

# Now copy it into our base image.
FROM gcr.io/distroless/base-debian11 AS final
COPY --from=build /go/bin/app /
CMD ["/app"]

FROM alpine AS live-update
WORKDIR /app
COPY build build
ENTRYPOINT build/tilt-example-go

