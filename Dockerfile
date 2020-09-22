# galaxy for hutlab

FROM bgruening/galaxy-stable

LABEL maintainer biobakery, forum.biobakery.org

ENV GALAXY_CONFIG_BRAND Hutlab
ENV GALAXY_DB_HOST=localhost \
    GALAXY_DB_USER=galaxy \
    GALAXY_DB_PASSWORD=galaxy \
    GALAXY_DB_NAME=galaxy \
    GALAXY_DB_PORT=5432 \
    GALAXY_VIRTUAL_ENV=/galaxy_venv \
    GALAXY_DATABASE_CONNECTION=postgresql://$GALAXY_DB_USER:"$GALAXY_DB_PASSWORD"@$GALAXY_DB_HOST:$GALAXY_DB_PORT/$GALAXY_DB_NAME \
    GALAXY_CONFIG_INTEGRATED_TOOL_PANEL_CONFIG=/export/galaxy-central/integrated_tool_panel.xml \
    ENABLE_TTS_INSTALL=True

WORKDIR /galaxy-central

COPY ./job_conf.xml /galaxy-central/config/job_conf.xml
COPY ./install_galaxy_python_deps.sh /galaxy-central/install_galaxy_python_deps.sh
COPY ./install.R /galaxy-central/install.R
COPY ./dependency_resolvers_conf.xml /galaxy-central/config/dependency_resolvers_conf.xml
COPY ./integrated_tool_panel.xml.lefse_fixed_order /galaxy-central/integrated_tool_panel.xml.lefse_fixed_order
COPY ./welcome.html $GALAXY_CONFIG_DIR/web/welcome.html
COPY ./datatypes_conf.xml /galaxy-central/config/datatypes_conf.xml
COPY ./tool_conf.xml /galaxy-central/config/tool_conf.xml
COPY ./install_tools.sh /usr/local/bin/install_tools.sh
COPY ./run_cron.sh /usr/local/bin/run_cron.sh
COPY ./run_db_backups.sh /usr/local/bin/run_db_backups.sh
COPY ./crontab /etc/cron.d/galaxy

RUN    apt-get update -qq 
RUN    apt-get upgrade -y 
RUN    apt-get install --no-install-recommends -y software-properties-common 
RUN    apt-get install --no-install-recommends -y bowtie2 build-essential
RUN    sudo -H -u galaxy /galaxy-central/install_galaxy_python_deps.sh 
RUN    chmod +x /usr/bin/startup 
RUN    chmod +x /usr/local/bin/install_tools.sh 
RUN    chmod g-w /var/log 
RUN    ln -s /galaxy-central /usr/local/galaxy-dist 
RUN    chmod +x /usr/bin/startup /usr/local/bin/install_* 
RUN    chmod g-w /var/log 
RUN    ln -s /galaxy-central /usr/local/galaxy-dist 
RUN    touch galaxy_install.log && chown galaxy:galaxy galaxy_install.log 
# RUN    add-tool-shed --u 'http://testtoolshed.g2.bx.psu.edu/' --name 'Test Tool Shed' && sleep 5 
# install-repository "-u https://testtoolshed.g2.bx.psu.edu/ -o george-weingart -n lefse --panel-section-name LEfSe -r a6284ef17bf3" && sleep 5 
RUN    bash /usr/local/bin/install_tools.sh 
RUN    chown -Rf galaxy:galaxy /galaxy-central/ 
RUN    apt-get update \
        && apt-get autoremove -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Mark folders as imported from the host.
VOLUME ["/export/", "/data/", "/var/lib/docker"]

# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy)
EXPOSE :80
EXPOSE :21
EXPOSE :8800

# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]