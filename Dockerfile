# temp stage
FROM python:3.7-bullseye as builder
USER root

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY . /app

RUN useradd -m user
USER user

RUN make install
RUN make build

# final stage
FROM python:3.7-bullseye
USER user

COPY --from=builder /opt/venv /opt/venv

WORKDIR /app

ENV PATH="/opt/venv/bin:$PATH"

EXPOSE 5000
