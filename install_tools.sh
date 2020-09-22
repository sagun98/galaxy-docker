#!/bin/bash
export GALAXY_VIRTUAL_ENV=/galaxy_venv
source $GALAXY_VIRTUAL_ENV/bin/activate

cd /galaxy-central/tools

# metaphlan2 and metaphlan2 galaxy installation
git clone https://github.com/biobakery/metaphlan2.git
git clone https://github.com/biobakery/galaxy_metaphlan2.git
cp galaxy_metaphlan2/metaphlan2.xml metaphlan2

# graphlan and graphlan galaxy installation
git clone https://github.com/biobakery/graphlan.git
git clone https://github.com/biobakery/galaxy_graphlan.git
cp -r graphlan/pyphlan /galaxy-central/lib/
cp -r galaxy_graphlan/* graphlan/

# Install metaphlan3
git clone https://github.com/biobakery/MetaPhlAn.git
git clone https://github.com/biobakery/galaxy_metaphlan3.git
cd MetaPhlAn
git checkout 3.0
ls
pip install .
metaphlan --install
cd ..
cp -r galaxy_metaphlan3/metaphlan3.xml metaphlan3

# git clone git://github.com/picrust/picrust.git picrust
# git clone https://github.com/biobakery/picrust-cmd.git
# cd picrust && git checkout tags/1.0.0 -b 1.0.0 && cd ..
# git clone https://github.com/biobakery/galaxy_picrust
# cp /galaxy-central/tools/galaxy_picrust/*.xml /galaxy-central/tools/picrust
# mkdir -p /galaxy-central/tools/picrust/data /galaxy_venv/local/lib/python2.7/site-packages/picrust/data/
# cd /galaxy_venv/local/lib/python2.7/site-packages/picrust/data/
# wget ftp://ftp.microbio.me/pub/picrust-references/picrust-1.0.0/16S_13_5_precalculated.tab.gz
# wget ftp://ftp.microbio.me/pub/picrust-references/picrust-1.0.0/ko_13_5_precalculated.tab.gz
# wget https://github.com/picrust/picrust/releases/download/0.9.2/16S_18may2012_precalculated.tab.gz
# wget https://github.com/picrust/picrust/releases/download/0.9.2/cog_18may2012_precalculated.tab.gz
# wget https://github.com/picrust/picrust/releases/download/0.9.2/ko_18may2012_precalculated.tab.gz
# cd /galaxy-central/tools/picrust
# python setup.py install


chown -Rf galaxy:galaxy /galaxy-central/tools /galaxy-central/lib
