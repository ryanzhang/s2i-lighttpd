# lighttpd-centos7
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
LABEL maintainer="Ryan Zhang <rzhang@redhat.com>"

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV LIGHTTPD_VERSION=1.4.35

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for static html files" \
      io.k8s.display-name="lighttpd 1.4.35" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,html,lighttpd."

# TODO: Install required packages here, epel repo is required to install lighttpd
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum install -y lighttpd && yum clean all -y

# TODO (optional): Copy the builder files into /opt/app-root
COPY ./etc /opt/app-root/etc

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 8080

# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]
