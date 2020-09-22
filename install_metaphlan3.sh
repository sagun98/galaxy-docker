#!/bin/bash

cd /galaxy-central/tools
git clone https://github.com/biobakery/MetaPhlAn.git
git clone https://github.com/biobakery/galaxy_metaphlan3.git
cd MetaPhlAn
git checkout 3.0
pip install .
metaphlan --install
cd ..
cp galaxy_metaphlan3/metaphlan3.xml MetaPhlAn
# chown -Rf galaxy:galaxy /galaxy-central/tools /galaxy-central/lib