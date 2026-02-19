FROM registry.redhat.io/ubi8/ubi-minimal:latest

# Update the image to get the latest CVE updates
RUN microdnf update -y \
 && microdnf install --nodocs \
    bash       \
    curl       \
    iproute    \
    keepalived-2.1.5 \
 && rm /etc/keepalived/keepalived.conf

COPY /skel /

RUN chmod +x init.sh

CMD ["./init.sh"]

# Build specific labels
LABEL maintainer="Guillaume Abrioux <gabrioux@redhat.com>"
LABEL com.redhat.component="keepalived-container"
LABEL version=2.1.5
LABEL name=rhceph/keepalived-rhel8
LABEL description="Red Hat Ceph Storage keepalived"
LABEL summary="Provides the keepalived on RHEL 8 for Red Hat Ceph Storage."
LABEL io.k8s.display-name="Keepalived on RHEL 8"
LABEL io.openshift.tags="rhceph ceph keepalived"

# Konflux specific labels
LABEL io.k8s.description="keepalived-container"
LABEL cpe=cpe:/a:redhat:ceph_storage:5.3::el8
