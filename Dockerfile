# # Stage 1: Base image for amd64
# FROM registry.access.redhat.com/ubi9-minimal:latest AS amd64

# # Update the image and install dependencies
# RUN microdnf update -y && \
#     microdnf install -y --nodocs bash curl-minimal iproute keepalived-2.2.8 && \
#     rm -f /etc/keepalived/keepalived.conf

# COPY /skel /
# RUN chmod +x init.sh

# # Stage 2: Base image for arm64
# FROM arm64v8/ubuntu:latest AS arm64

# # Update and install similar dependencies for ARM64
# RUN apt-get update -y && \
#     apt-get install -y bash curl iproute2 && \
#     apt-get clean

# COPY /skel /
# RUN chmod +x init.sh

# # Final stage: Use appropriate base for the target platform
# FROM amd64 AS final

# # Copy platform-specific files from the appropriate stage
# COPY --from=amd64 / /      # Copy from amd64 stage
# COPY --from=arm64 / /      # Copy from arm64 stage

# # Final setup
# CMD ["./init.sh"]

# # Build labels
# LABEL maintainer="Guillaume Abrioux <gabrioux@redhat.com>"
# LABEL com.redhat.component="keepalived-container"
# LABEL version=2.2.8
# LABEL name="keepalived"
# LABEL description="Red Hat Ceph Storage keepalived"
# LABEL summary="Provides the keepalived on RHEL 9 for Red Hat Ceph Storage."
# LABEL io.k8s.display-name="Keepalived on RHEL 9"
# LABEL io.openshift.tags="rhceph ceph keepalived"

FROM --platform=$BUILDPLATFORM registry.access.redhat.com/ubi9-minimal

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
LABEL name="keepalived"
LABEL description="Red Hat Ceph Storage keepalived"
LABEL summary="Provides the keepalived on RHEL 9 for Red Hat Ceph Storage."
LABEL io.k8s.display-name="Keepalived on RHEL 9"
LABEL io.openshift.tags="rhceph ceph keepalived"