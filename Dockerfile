# syntax=docker/dockerfile:1
FROM python:3
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

## Argumento para etiqueta de ambiente (environment)
ARG ENVIRONMENT=unknown

## Etiqueta de ambiente (Ej. DEV o PROD)
LABEL environment=$ENVIRONMENT

## Variables para conexión a base de datos. 
ENV POSTGRES_NAME=postgres
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_HOST=db_tema3

## Configurar directorio de trabajo
WORKDIR /code

## Copiar archivo de requerimientos a directorio de trabajo /code/
COPY requirements.txt /code/

## Ejecución de instalación de requerimientos de Django.
RUN pip install -r requirements.txt

## Volumen para imagenes URL localhost:8081/upload
## Para acceder las imagenes URL localhost:8081/media/<nombre de la imagen cargada>
VOLUME /media/

## Copia de archivo de inicialización de Django a directorio de trabajo /code/
COPY pythonmanage.sh /code/

## Copia del resto del código a /code/
COPY . /code/

## Exposición del puerto 8081
EXPOSE 8081

## Cambio de permisos para archivo de inicialización de Django.
RUN /bin/bash -c 'chmod +x /code/pythonmanage.sh'

## Inicialización de Django
ENTRYPOINT ["/bin/sh", "-c", "/code/pythonmanage.sh"]