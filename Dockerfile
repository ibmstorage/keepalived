# Use a multi-architecture-compatible base image
FROM almalinux:9

# Update the image to get the latest CVE updates
RUN dnf update -y \
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
LABEL name="keepalived"
LABEL description="Red Hat Ceph Storage keepalived"
LABEL summary="Provides the keepalived on RHEL 9 for Red Hat Ceph Storage."
LABEL io.k8s.display-name="Keepalived on RHEL 9"
LABEL io.openshift.tags="rhceph ceph keepalived"
