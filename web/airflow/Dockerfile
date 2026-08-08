FROM --platform=$BUILDPLATFORM docker.io/apache/airflow:3.2.2-python3.14

# Setup Airflow
ENV AIRFLOW_VERSION=3.2.2
ENV PYTHON_VERSION=3.14
COPY webserver_config.py $AIRFLOW_HOME/
COPY dags $AIRFLOW_HOME/dags
RUN pip install uv \
    && uv pip install "apache-airflow[celery,google,postgres,fab,standard]==${AIRFLOW_VERSION}"

USER root
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh



USER airflow
EXPOSE 8080
ENTRYPOINT [ "/entrypoint.sh" ]
