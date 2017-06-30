FROM centos:7
LABEL maintainer="andreas.kratzer@kit.edu"

RUN yum -y install \
	krb5-workstation

ENV \
	TINI_VERSION=0.14.0 \
	TINI_SHA512SUM=a6d591dbe579b79b1ba0df0096a0987f923d2b3ef15471d5264b7a1fc57b4c421b6dd5bb889184a4cc801a0ac9246eb7895cfdc7d947c1d3d4e3f231da2b30b8

ADD https://github.com/krallin/tini/releases/download/v$TINI_VERSION/tini-amd64 /usr/local/bin/tini
RUN \
	echo "$TINI_SHA512SUM  /usr/local/bin/tini" | sha512sum -c && \
	chmod +x /usr/local/bin/tini

COPY entrypoint.d/ /entrypoint.d/
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
