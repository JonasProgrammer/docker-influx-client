# docker-influx-client
Influx SSH Client

This image creates a container exposing an `influx` shell via SSH on port 22. It supports the
4 default users provided by the official [influxdb](https://hub.docker.com/_/influxdb) image
or my [secret-enabled version](https://hub.docker.com/r/jonasprogrammer/influxdb) respectively.

The user is determined by the SSH key, thus you must use different SSH keys per influx user.

Multiple SSH keys per user are supported using a comma separated list.

## Usage

The container's `authorized_keys` file with the corresponding forced commands to open the
influx shell is regenerated on every container startup. The following environment variables
influence it's generation.

### INFLUXDB_HOST

The hostname of the server to connect to. Defaults to `db`.

### INFLUXDB_DB

The database to connect to.

### INFLUXDB_ADMIN_USER

The name of the admin user.

### INFLUXDB_ADMIN_PASSWORD\[_FILE]

The password for the admin user configured with `INFLUXDB_ADMIN_USER`.

### INFLUXDB_ADMIN_KEYS\[_FILE]

Comma-separated list of SSH public keys (OpenSSH `authorized_keys` format) allowed to
connect as `INDLUXDB_ADMIN_USER`.

### INFLUXDB_USER

The name of the admin user.

### INFLUXDB_USER_PASSWORD\[_FILE]

The password for the admin user configured with `INFLUXDB_USER`.

### INFLUXDB_USER_KEYS\[_FILE]

Comma-separated list of SSH public keys (OpenSSH `authorized_keys` format) allowed to
connect as `INDLUXDB_USER`.

### INFLUXDB_READ_USER

The name of the admin user.

### INFLUXDB_READ_USER_PASSWORD\[_FILE]

The password for the admin user configured with `INFLUXDB_READ_USER`.

### INFLUXDB_READ_USER_KEYS\[_FILE]

Comma-separated list of SSH public keys (OpenSSH `authorized_keys` format) allowed to
connect as `INDLUXDB_READ_USER`.

### INFLUXDB_WRITE_USER

The name of the admin user.

### INFLUXDB_WRITE_USER_PASSWORD\[_FILE]

The password for the admin user configured with `INFLUXDB_WRITE_USER`.

### INFLUXDB_WRITE_USER_KEYS\[_FILE]

Comma-separated list of SSH public keys (OpenSSH `authorized_keys` format) allowed to
connect as `INDLUXDB_WRITE_USER`.
