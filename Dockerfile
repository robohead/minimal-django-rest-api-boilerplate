FROM python:3.6
ENV PYTHONUNBUFFERED 1
MAINTAINER Anton Alekseev <zxtiger@protonmail.com>

RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/
RUN python manage.py migrate

