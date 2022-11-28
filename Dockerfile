FROM python:3.7-bullseye
USER root

RUN pip install --upgrade pip
RUN pip install openfisca_gme
RUN pip install --upgrade setuptools

WORKDIR /app
COPY . /app

RUN make install
RUN make build

RUN useradd -m user
USER user

EXPOSE 5000

CMD ["bash"]
