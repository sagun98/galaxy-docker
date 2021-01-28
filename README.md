Please see <https://github.com/bgruening/docker-galaxy-stable> for details on the config.

This build modifies the toolbar config and adds updated R, matplotlib, and a few other things.

```
docker build -t galaxy-upgrade-test-image .

docker run -p 8080:80 galaxy-upgrade-test-image

sudo docker run \
-d \

-e "PROXY_PREFIX=/test" \
-p 8080:80 \
-p 21:21 \
galaxy-upgrade-test-image

<!-- Local -->
sudo docker run \
-d \
-v /Users/sam1389/Desktop/workspace/export:/export/ \
-e ENABLE_TTS_INSTALL=True \
-e "PROXY_PREFIX=/test" \
-e "GALAXY_CONFIG_ADMIN_USERS=admin@galaxy.org" \
-e GALAXY_LOGGING=full \
-e GALAXY_CONFIG_MASTER_API_KEY=fakekey \
-p 8080:80 \
-p 21:21 \
galaxy-upgrade-test-image

<!-- Cluster -->
sudo docker run \
-d \
-v /data/galaxy-data-upgrade:/export/ \
-v /var/localgalaxy/:/var/localgalaxy \
-e GALAXY_CONFIG_INTEGRATED_TOOL_PANEL_CONFIG=/export/galaxy-central/integrated_tool_panel.xml \
-e GALAXY_VIRTUALENV=/export/galaxy-central/venv \
-e ENABLE_TTS_INSTALL=True \
-e PROXY_PREFIX=/galaxy \
-e "GALAXY_CONFIG_ADMIN_USERS=admin@galaxy.org" \
-e GALAXY_LOGGING=full \
-e http_proxy=http://140.247.151.117/galaxy \
-e GALAXY_CONFIG_MASTER_API_KEY=fakekey \
-p 8080:80 \
-p 21:21 \
galaxy-upgrade-test-image

sudo docker run \
-d \
-v /data/galaxy-data-version-20:/export/ \
-v /var/localgalaxy/:/var/localgalaxy \
-e GALAXY_CONFIG_INTEGRATED_TOOL_PANEL_CONFIG=/export/galaxy-central/integrated_tool_panel.xml \
-e GALAXY_VIRTUALENV=/export/galaxy-central/venv \
-e ENABLE_TTS_INSTALL=True \
-e PROXY_PREFIX=/galaxy \
-e "GALAXY_CONFIG_ADMIN_USERS=admin@galaxy.org" \
-e GALAXY_LOGGING=full \
-e http_proxy=http://140.247.151.117/galaxy \
-e GALAXY_CONFIG_MASTER_API_KEY=fakekey \
-p 8080:80 \
-p 21:21 \
galaxy_version_20



sudo docker run -p 8080:80 -p 21:21 -v /data/galaxy-data:/export -e PROXY_PREFIX=/galaxy --name galaxy-version20-3 bgruening/galaxy-stable 

```