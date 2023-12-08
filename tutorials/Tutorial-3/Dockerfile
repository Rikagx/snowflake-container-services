ARG BASE_IMAGE=python:3.10-slim-buster
FROM $BASE_IMAGE
COPY service_to_service.py ./
RUN pip install --upgrade pip && \
    pip install requests
CMD ["python3", "service_to_service.py"]

