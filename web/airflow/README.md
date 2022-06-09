```bash
# 
airflow db init

# 
airflow scheduler -D

# 
airflow users create \
    --username admin \
    --firstname admin \
    --lastname admin \
    --role Admin \
    --email admin@localhost.com

airflow webserver -D
```
