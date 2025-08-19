```
# 1) DB connection (edit endpoint/db/user/pass)
kubectl -n $NS create secret generic polaris-db-conn \
  --from-literal=username='postgres' \
  --from-literal=password='1aX' \
  --from-literal=jdbcUrl='jdbc:postgresql://new-instance-1.c7imu4ewmq69.us-east-1.rds.amazonaws.com:5432'

```

```
persistence:
  type: relational-jdbc
  relationalJdbc:
    secret:
      name: polaris-db-conn   # <- the Secret created above
      username: username
      password: password
      jdbcUrl: jdbcUrl

extraEnv:
  - name: QUARKUS_DATASOURCE_DB_KIND
    value: postgresql
  - name: QUARKUS_DATASOURCE_JDBC_URL
    valueFrom:
      secretKeyRef:
        name: polaris-db-conn
        key: jdbcUrl
  - name: QUARKUS_DATASOURCE_USERNAME
    valueFrom:
      secretKeyRef:
        name: polaris-db-conn
        key: username
  - name: QUARKUS_DATASOURCE_PASSWORD
    valueFrom:
      secretKeyRef:
        name: polaris-db-conn
        key: password

```
