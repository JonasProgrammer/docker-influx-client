export HOME="${SESSION_DIR}/$(dd if=/dev/urandom bs=1c count=64 status=none | sha256sum - | awk '{ print $1 }')"

mkdir -p $HOME

influx -host "$HOST" -database "$DB" -username "$USER" -password "$PASSWORD"

rm -Rf $HOME
