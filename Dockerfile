# temp stage
FROM python:3.7-bullseye as builder
USER root

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc

RUN make install
RUN make build

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY . /app

# final stage
FROM python:3.7-bullseye
USER root

COPY --from=builder /opt/venv /opt/venv

WORKDIR /app

ENV PATH="/opt/venv/bin:$PATH"

RUN useradd -m user
USER user

EXPOSE 5000
