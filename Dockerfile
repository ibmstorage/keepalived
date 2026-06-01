FROM registry.access.redhat.com/ubi10-minimal:latest

# Update the image to get the latest CVE updates
RUN microdnf update -y \
 && microdnf install -y --nodocs \
    bash         \
    curl-minimal \
    iproute      \
    keepalived-2.2.8 \
 && rm /etc/keepalived/keepalived.conf

COPY /skel /

RUN mkdir /licenses
COPY ./licenses /licenses

RUN chmod +x init.sh

CMD ["./init.sh"]

# Build specific labels
LABEL maintainer="Guillaume Abrioux <gabrioux@redhat.com>"
LABEL com.redhat.component="keepalived-container"
LABEL version=2.2.8
LABEL name=rhceph/keepalived-rhel10
LABEL description="Red Hat Ceph Storage keepalived"
LABEL summary="Provides the keepalived on RHEL 10 for Red Hat Ceph Storage."
LABEL io.k8s.display-name="Keepalived on RHEL 10"
LABEL io.k8s.description="Red Hat Ceph Storage keepalived"
LABEL io.openshift.tags="rhceph ceph keepalived"
LABEL cpe=cpe:/a:redhat:ceph_storage:9.1::el10
