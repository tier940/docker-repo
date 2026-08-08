# Docker Airflow
## Informations

* Based on official Airflow 3 Image [apache/airflow:3.2.2-python3.14](https://hub.docker.com/r/apache/airflow) and uses the official [Postgres](https://hub.docker.com/_/postgres/) as backend and [Redis](https://hub.docker.com/_/redis/) as queue
* Docker entrypoint script is forked from [dataops-sre/docker-airflow2](https://github.com/dataops-sre/docker-airflow2)
* Install [Docker](https://www.docker.com/)
* Install [Docker Compose](https://docs.docker.com/compose/install/)

## Usage

Airflow 3 removed SequentialExecutor, so a database is always required. Use the compose files provided in this repository.

For **LocalExecutor** :

    docker compose -f docker-compose-LocalExecutor.yml up -d

For **CeleryExecutor** :

    docker compose -f docker-compose-CeleryExecutor.yml up -d

Airflow 3 also requires the scheduler, dag-processor, triggerer and api-server to run as independent
processes. Both compose files start them as separate services.

NB : If you want to have DAGs example loaded (default=False), you've to set the following environment variable in docker-compose files :

`AIRFLOW__CORE__LOAD_EXAMPLES=True`


If you want to use Ad hoc query, make sure you've configured connections:
Go to Admin -> Connections and Edit "postgres_default" set this values (equivalent to values in airflow.cfg/docker*.yml) :
- Host : postgres
- Schema : airflow
- Login : airflow
- Password : airflow

## Secrets

Both compose files read two secrets from `.env` (see `.env.example` for the template). They must be
identical across all containers:

| Variable              | Role                                                                       |
|-----------------------|----------------------------------------------------------------------------|
| `AIRFLOW_FERNET_KEY`  | Encrypts connection passwords                                              |
| `AIRFLOW_JWT_SECRET`  | Authenticates task workers against the Execution API (required in Airflow 3) |

The values committed in `.env.example` are empty on purpose. Generate your own:

    python -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())"
    python -c "import secrets; print(secrets.token_hex(32))"

`.env` is gitignored, so your real keys stay out of the repository.

## Configuring Airflow

It's possible to set any configuration value for Airflow from environment variables

The general rule is the environment variable should be named `AIRFLOW__<section>__<key>`, for example `AIRFLOW__DATABASE__SQL_ALCHEMY_CONN` sets the `sql_alchemy_conn` config option in the `[database]` section.

Check out the [Airflow documentation](https://airflow.apache.org/docs/apache-airflow/stable/configurations-ref.html) for more details

You can also define connections via environment variables by prefixing them with `AIRFLOW_CONN_` - for example `AIRFLOW_CONN_POSTGRES_MASTER=postgres://user:password@localhost:5432/master` for a connection called "postgres_master". The value is parsed as a URI. This will work for hooks etc, but won't show up in the "Ad-hoc Query" section unless an (empty) connection is also created in the DB

## Custom Airflow plugins

Airflow allows for custom user-created plugins which are typically found in `${AIRFLOW_HOME}/plugins` folder. Documentation on plugins can be found [here](https://airflow.apache.org/docs/apache-airflow/stable/plugins.html)

In order to incorporate plugins into your docker container
- Create the plugins folders `plugins/` with your custom plugins.
- Mount the folder as a volume, either with `-v $(pwd)/plugins/:/opt/airflow/plugins` on the command
  line, or by adding it to the `volumes:` list of the relevant services in the compose file.

## Install custom python package

- Create a file "requirements.txt" with the desired python modules
- Mount this file as a volume `-v $(pwd)/requirements.txt:/opt/airflow/requirements.txt` (or add it as a volume in docker-compose file)
- The entrypoint.sh script execute the `uv pip install` command (with --user option)

## UI Links

- Airflow: [localhost:8080](http://localhost:8080/)
- Flower: [localhost:5555](http://localhost:5555/)


## Scale the number of workers

Easy scaling using docker-compose:

    docker compose -f docker-compose-CeleryExecutor.yml scale worker=5

This can be used to scale to a multi node setup using docker swarm.

## Running other airflow commands

If you want to run other airflow sub-commands, such as `list_dags` or `clear` you can do so like this:

    docker run --rm -ti ghcr.io/tier940/airflow airflow dags list

or with your docker-compose set up like this:

    docker compose -f docker-compose-CeleryExecutor.yml run --rm webserver airflow dags list

You can also use this to run a bash shell or any other command in the same environment that airflow would be run in:

    docker run --rm -ti ghcr.io/tier940/airflow bash
    docker run --rm -ti ghcr.io/tier940/airflow ipython

# Simplified SQL database configuration using PostgreSQL

Here is a list of PostgreSQL configuration variables and their default values. They're used to compute
the `AIRFLOW__DATABASE__SQL_ALCHEMY_CONN` and `AIRFLOW__CELERY__RESULT_BACKEND` variables when needed for you
if you don't provide them explicitly:

| Variable            | Default value |  Role                |
|---------------------|---------------|----------------------|
| `POSTGRES_HOST`     | `postgres`    | Database server host |
| `POSTGRES_PORT`     | `5432`        | Database server port |
| `POSTGRES_USER`     | `airflow`     | Database user        |
| `POSTGRES_PASSWORD` | `airflow`     | Database password    |
| `POSTGRES_DB`       | `airflow`     | Database name        |
| `POSTGRES_EXTRAS`   | empty         | Extras parameters    |

You can also use those variables to adapt your compose file to match an existing PostgreSQL instance managed elsewhere.

Please refer to the Airflow documentation to understand the use of extras parameters, for example in order to configure
a connection that uses TLS encryption.

Here's an important thing to consider:

> When specifying the connection as URI (in AIRFLOW_CONN_* variable) you should specify it following the standard syntax of DB connections,
> where extras are passed as parameters of the URI (note that all components of the URI should be URL-encoded).

Therefore you must provide extras parameters URL-encoded, starting with a leading `?`. For example:

    POSTGRES_EXTRAS="?sslmode=verify-full&sslrootcert=%2Fetc%2Fssl%2Fcerts%2Fca-certificates.crt"

# Simplified Celery broker configuration using Redis

If the executor type is set to *CeleryExecutor* you'll need a Celery broker. Here is a list of Redis configuration variables
and their default values. They're used to compute the `AIRFLOW__CELERY__BROKER_URL` variable for you if you don't provide
it explicitly:

| Variable          | Default value | Role                           |
|-------------------|---------------|--------------------------------|
| `REDIS_PROTO`     | `redis://`    | Protocol                       |
| `REDIS_HOST`      | `redis`       | Redis server host              |
| `REDIS_PORT`      | `6379`        | Redis server port              |
| `REDIS_PASSWORD`  | empty         | If Redis is password protected |
| `REDIS_DBNUM`     | `1`           | Database number                |

You can also use those variables to adapt your compose file to match an existing Redis instance managed elsewhere.

# Wanna help?

Fork, improve and PR.
