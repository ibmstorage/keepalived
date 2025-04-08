# Use a multi-architecture-compatible base image
FROM debian:bullseye-slim

# Disable interactive prompts and init scripts
ENV DEBIAN_FRONTEND=noninteractive
RUN mkdir -p /usr/sbin && echo '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d

# Update the image to get the latest CVE updates
RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    bash \
    curl \
    iproute2 \
    keepalived \
    && rm -rf /var/lib/apt/lists/*

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
