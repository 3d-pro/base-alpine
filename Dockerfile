FROM alpine:edge

ENV TERM=xterm
RUN mkdir -p /etc/apk && echo "http://alpine.gliderlabs.com/alpine/edge/main" > /etc/apk/repositories && \
    echo "http://alpine.gliderlabs.com/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://alpine.gliderlabs.com/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add openrc rsyslog bash && \
    rc-update add rsyslog default && \
    sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf && \
    echo 'rc_provide="loopback net"' >> /etc/rc.conf && \
    sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf && \
    sed -i '/tty/d' /etc/inittab && \
    sed -i 's/hostname $opts/# hostname $opts/g' /etc/init.d/hostname && \
    sed -i 's/mount -t tmpfs/# mount -t tmpfs/g' /lib/rc/sh/init.sh && \
    sed -i 's/cgroup_add_service /# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh

CMD ["/sbin/init"]
