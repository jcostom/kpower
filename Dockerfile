FROM python:slim

ARG TZ=America/New_York

RUN \
    pip install python-kasa \
    && pip install influxdb-client \
    && pip cache purge

RUN mkdir /app
COPY ./kpower.py /app
RUN chmod 755 /app/kpower.py

ENTRYPOINT [ "python3", "-u", "/app/kpower.py" ]