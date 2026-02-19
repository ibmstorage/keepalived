
FROM registry.access.redhat.com/ubi9-minimal:latest

# Update the image to get the latest CVE updates
RUN microdnf update -y \
 && microdnf install -y --nodocs \
    bash         \
    curl-minimal \
    iproute      \
    keepalived-2.2.8 \
 && rm /etc/keepalived/keepalived.conf

COPY /skel /

RUN chmod +x init.sh

CMD ["./init.sh"]

# Build specific labels
LABEL maintainer="Guillaume Abrioux <gabrioux@redhat.com>"
LABEL com.redhat.component="keepalived-container"
LABEL version=2.2.8
LABEL name=rhceph/keepalived-rhel9
LABEL description="Red Hat Ceph Storage keepalived"
LABEL summary="Provides the keepalived on RHEL 9 for Red Hat Ceph Storage."
LABEL io.k8s.display-name="Keepalived on RHEL 9"
LABEL io.k8s.description="keepalived-container"
LABEL io.openshift.tags="rhceph ceph keepalived"
LABEL cpe=cpe:/a:redhat:ceph_storage:6.1::el9
