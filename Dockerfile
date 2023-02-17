ARG PYTHON_VERSION=3.10-slim-buster

FROM python:${PYTHON_VERSION}

LABEL org.opencontainers.image.source=https://github.com/PedroH31/TwelveFactorApp
LABEL org.opencontainers.image.licenses=MIT

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY requirements.txt ./requirements.txt

RUN set -ex && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . /app/

# RUN python manage.py collectstatic --noinput

EXPOSE 8000

# replace demo.wsgi with <project_name>.wsgi
CMD ["gunicorn", "--bind", ":8080", "--workers", "2", "dozefatores.wsgi"]
