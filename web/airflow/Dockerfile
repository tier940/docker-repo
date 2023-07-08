FROM --platform=$BUILDPLATFORM docker.io/apache/airflow:2.6.2-python3.10

# Setup Airflow
ENV AIRFLOW_VERSION=2.6.2
ENV PYTHON_VERSION=3.10

COPY entrypoint.sh /entrypoint.sh
RUN pip install "apache-airflow[crypto,celery,google,postgres]==${AIRFLOW_VERSION}"

USER root
RUN chmod +x /entrypoint.sh

USER airflow
COPY webserver_config.py $AIRFLOW_HOME/
COPY dags $AIRFLOW_HOME/dags



EXPOSE 8080
ENTRYPOINT [ "/entrypoint.sh" ]
