Please see <https://github.com/bgruening/docker-galaxy-stable> for details on the config.

This build modifies the toolbar config and adds updated R, matplotlib, and a few other things.

docker build -t galaxy-upgrade-test-image .

docker run -p 8080:80 galaxy-upgrade-test-image