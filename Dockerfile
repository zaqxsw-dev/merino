### Build container
FROM rust:latest as builder
WORKDIR /usr/src/myapp
COPY . .
RUN cargo install --path .
### Runtime container
FROM debian:buster-slim
COPY ./users.csv .
RUN apt-get update && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/merino /usr/local/bin/merino
CMD ["merino", "--users", "users.csv"] # with auth defined in users.csv
#CMD ["merino", "--no-auth"] # no auth
