FROM influxdb:1.5

ENV CLIENT_HOME /var/lib/influx-client
ENV SESSION_DIR $CLIENT_HOME/sessions
ENV INFLUXDB_HOST db

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && apt-get install -y --no-install-recommends openssh-server \
 && rm -rf /var/lib/apt/lists/* \
 && adduser --gecos '' --disabled-password --disabled-login --home $CLIENT_HOME --no-create-home influx-client \
 && mkdir -p $CLIENT_HOME \
 && mkdir -p $CLIENT_HOME/.ssh \
 && mkdir -p $SESSION_DIR && chown -R influx-client:influx-client $SESSION_DIR \
 && mkdir -p /run/sshd \
 && sed -i 's/^X11.*$/#\0/g' /etc/ssh/sshd_config \
 && echo "PasswordAuthentication no" >>/etc/ssh/sshd_config \
 && echo "PermitRootLogin no" >>/etc/ssh/sshd_config \
 && echo "X11Forwarding no" >>/etc/ssh/sshd_config \
 && echo "AllowTcpForwarding no" >>/etc/ssh/sshd_config

EXPOSE 22

COPY entrypoint.sh /entrypoint.sh
COPY in.session-setup.sh /in.session-setup.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
