FROM python:3.10-slim

# Setup Airflow
ENV AIRFLOW_VERSION=2.3.2
ENV PYTHON_VERSION=3.10
RUN pip install "apache-airflow[google]==${AIRFLOW_VERSION}" \
  --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"

EXPOSE 8080
