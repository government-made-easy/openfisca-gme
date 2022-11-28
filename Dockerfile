FROM python:3.7-bullseye
USER root

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY . /app

RUN make install
RUN make build

RUN useradd -m user
USER user

EXPOSE 5000