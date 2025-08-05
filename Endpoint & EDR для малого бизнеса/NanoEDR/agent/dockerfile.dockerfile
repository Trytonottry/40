FROM rust:1.78 AS builder
WORKDIR /src
COPY agent .
RUN cargo build --release

FROM debian:bookworm-slim
COPY --from=builder /src/target/release/nanoedr /usr/local/bin/
CMD ["nanoedr"]