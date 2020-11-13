########### Liberty setup ###########

FROM adoptopenjdk/openjdk8-openj9:ubi

ARG LIBERTY_VERSION=20.0.0.11
ARG LIBERTY_DOWNLOAD_URL=https://repo1.maven.org/maven2/io/openliberty/openliberty-runtime/$LIBERTY_VERSION/openliberty-runtime-$LIBERTY_VERSION.zip

# Download and install Liberty
RUN mkdir -p /opt/ol/wlp
RUN yum -y install wget unzip && wget -q $LIBERTY_DOWNLOAD_URL -O /tmp/wlp.zip && unzip -q /tmp/wlp.zip -d /opt/ol

# Set logs directory
ENV LOG_DIR=/logs

# Create server and symlink to config dir
RUN /opt/ol/wlp/bin/server create
RUN ln -s /opt/ol/wlp/usr/servers/defaultServer /config

########### Application setup ###########

# Add config
COPY --chown=1001:0  target/liberty/wlp/usr/servers/defaultServer/server.xml /config/
COPY --chown=1001:0  target/liberty/wlp/usr/servers/defaultServer/bootstrap.properties /config/
COPY --chown=1001:0  target/liberty/wlp/usr/servers/defaultServer/configDropins/overrides/liberty-plugin-variable-config.xml /config/configDropins/overrides/

# Add application
COPY --chown=1001:0  target/liberty/wlp/usr/servers/defaultServer/apps/demo-devmode-maven.war /config/apps/