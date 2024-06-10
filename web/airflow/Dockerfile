FROM --platform=$BUILDPLATFORM docker.io/apache/airflow:2.9.2-python3.11

# Setup Airflow
ENV AIRFLOW_VERSION=2.8.3
ENV PYTHON_VERSION=3.11
COPY webserver_config.py $AIRFLOW_HOME/
COPY dags $AIRFLOW_HOME/dags
RUN pip install uv \
    && uv venv \
    && uv pip install "apache-airflow[crypto,celery,google,postgres]==${AIRFLOW_VERSION}"

USER root
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh



USER airflow
EXPOSE 8080
ENTRYPOINT [ "/entrypoint.sh" ]
