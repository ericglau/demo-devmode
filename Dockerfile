FROM openliberty/open-liberty:kernel-java8-openj9-ubi

# Add config
COPY --chown=1001:0  target/liberty/wlp/usr/servers/defaultServer/server.xml /config/
COPY --chown=1001:0  target/liberty/wlp/usr/servers/defaultServer/bootstrap.properties /config/
COPY --chown=1001:0  target/liberty/wlp/usr/servers/defaultServer/configDropins/overrides/liberty-plugin-variable-config.xml /config/configDropins/overrides/

# Add application
COPY --chown=1001:0  target/liberty/wlp/usr/servers/defaultServer/apps/demo-devmode-maven.war /config/apps/