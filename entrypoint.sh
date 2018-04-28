#!/bin/sh

set -e

infixes="ADMIN USER READ_USER WRITE_USER"

vars=""

for i in $infixes; do
  vars="$vars INFLUXDB_${i}_PASSWORD INFLUXDB_${i}_KEYS"
done

for var in $vars; do
  eval val="\$$var"
  eval val_file="\$${var}_FILE"
  if [ -z "$val" -a -n "$val_file" ]; then
    export "$var"=$(cat "$val_file")
  fi
done

oldifs="$IFS"

file=$CLIENT_HOME/.ssh/authorized_keys
rm -f $file

# Workaround: username for admin is INFLUXDB_infix_USER instead of INFLUXDB_infix
INFLUXDB_ADMIN="$INFLUXDB_ADMIN_USER"

for i in $infixes; do
  eval user="\$INFLUXDB_${i}"
  eval pass="\$INFLUXDB_${i}_PASSWORD"

  command="/${i}.session-setup.sh"

  cat >$command <<EOF
#!/bin/sh
HOST="$INFLUXDB_HOST"
DB="$INFLUXDB_DB"
USER="$user"
PASSWORD="$pass"

SESSION_DIR="$SESSION_DIR"

$(cat /in.session-setup.sh)
EOF
  chmod +x $command

  eval keys="\$INFLUXDB_${i}_KEYS"
  options="command=\"${command}\",no-port-forwarding,no-x11-forwarding,no-agent-forwarding"
  IFS=,
  for k in $keys; do
    echo "$options $k" >>$file
  done

  IFS="$oldifs"
done

echo $(cat $file)

exec $@
