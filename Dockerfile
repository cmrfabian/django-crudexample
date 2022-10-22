# syntax=docker/dockerfile:1
FROM python:3
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

## Configurar directorio de trabajo
WORKDIR /code

## Copiar archivo de requerimientos a directorio de trabajo /code/
COPY requirements.txt /code/

## Ejecución de instalación de requerimientos de Django.
RUN pip install -r requirements.txt

## Volumen para imagenes URL localhost:8081/upload
## Para acceder las imagenes URL localhost:8081/media/<nombre de la imagen cargada>
#VOLUME /media/

## Copia del resto del código a /code/
COPY . /code/