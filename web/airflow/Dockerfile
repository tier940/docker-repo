FROM --platform=$BUILDPLATFORM docker.io/apache/airflow:2.8.0-python3.11

# Setup Airflow
ENV AIRFLOW_VERSION=2.7.3
ENV PYTHON_VERSION=3.11

COPY entrypoint.sh /entrypoint.sh
RUN pip install "apache-airflow[crypto,celery,google,postgres]==${AIRFLOW_VERSION}"

USER root
RUN chmod +x /entrypoint.sh

USER airflow
COPY webserver_config.py $AIRFLOW_HOME/
COPY dags $AIRFLOW_HOME/dags



EXPOSE 8080
ENTRYPOINT [ "/entrypoint.sh" ]
