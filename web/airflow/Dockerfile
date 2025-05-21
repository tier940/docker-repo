FROM --platform=$BUILDPLATFORM docker.io/apache/airflow:-python3.12

# Setup Airflow
ENV AIRFLOW_VERSION=2.11.0
ENV PYTHON_VERSION=3.12
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
