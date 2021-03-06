#!/bin/sh

# Check that the containers are available

[ ! -z $(docker images -q motrpac-prot-masic:v1.2_20200901) ] || echo "docker container < motrpac-prot-masic:v1.2_20200901 > does not exist"
[ ! -z $(docker images -q chambm/pwiz-skyline-i-agree-to-the-vendor-licenses) ] || echo "docker image < msconvert > does not exist"
[ ! -z $(docker images -q motrpac-prot-msgfplus:v1.2_20200901) ] || echo "docker container < motrpac-prot-msgfplus:v1.2_20200901 > does not exist"
[ ! -z $(docker images -q motrpac-prot-ppmerror:v1.2_20200901) ] || echo "docker container < motrpac-prot-ppmerror:v1.2_20200901 > does not exist"
[ ! -z $(docker images -q motrpac-prot-mzid2tsv:v1.2_20200901) ] || echo "docker container < motrpac-prot-mzid2tsv:v1.2_20200901 > does not exist"
[ ! -z $(docker images -q motrpac-prot-phrp:v1.2_20200901) ] || echo "docker container < motrpac-prot-phrp:v1.2_20200901 > does not exist"
[ ! -z $(docker images -q motrpac-prot-plexedpiper:v1.2_20200901) ] || echo "docker container < motrpac-prot-plexedpiper:v1.2_20200901 > does not exist"

# Step 00
docker run -v $PWD/data:/data:rw \
-v $PWD/parameters:/parameters:rw \
-v $PWD/step00:/step00:rw \
motrpac-prot-masic:v1.2_20200901 bash step00/step00masic_ubiq.sh

# Step 01
docker run --rm \
-e WINEDEBUG=-all \
-v $PWD/data:/data:rw \
chambm/pwiz-skyline-i-agree-to-the-vendor-licenses \
wine msconvert /data/test_ubiq/raw/*.raw \
-o /data/test_ubiq/msgfplus_input/

# Step 02
docker run \
-v $PWD/data:/data:rw \
-v $PWD/parameters:/parameters:rw \
-v $PWD/step02:/step02:rw \
motrpac-prot-msgfplus:v1.2_20200901 bash step02/step02msgfplus_tryptic_ubiq.sh

# Step 03a
sh step03/step03a_ubiq.sh

# Step 03b
docker run -v $PWD/data:/data:rw \
-v $PWD/parameters:/parameters:rw \
-v $PWD/step03:/step03:rw \
motrpac-prot-ppmerror:v1.2_20200901 bash step03/step03b_ubiq.sh

# Step 04
docker run -v $PWD/data:/data:rw \
-v $PWD/parameters:/parameters:rw \
-v $PWD/step04:/step04:rw \
motrpac-prot-msgfplus:v1.2_20200901 bash step04/step04msgfplus_ubiq.sh

# Step 05
docker run -v $PWD/data:/data:rw \
-v $PWD/parameters:/parameters:rw \
-v $PWD/step05:/step05:rw \
motrpac-prot-mzid2tsv:v1.2_20200901 bash step05/step05net462_ubiq.sh

# Step 06
docker run -v $PWD/data:/data:rw \
-v $PWD/parameters:/parameters:rw \
-v $PWD/step06:/step06:rw \
motrpac-prot-phrp:v1.2_20200901 bash step06/step06phrp_ubiq.sh

# Relative quantification step
docker run -v $PWD/data:/data:rw \
-v $PWD/relquant:/relquant:rw \
motrpac-prot-plexedpiper:v1.2_20200901 bash relquant/relquant_ubiq.sh



