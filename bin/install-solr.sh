#!/usr/bin/env bash

SOLR_PORT=${SOLR_PORT:-8983}

download() {
    echo "Downloading solr from $1..."
    curl -s $1 | tar xz
    echo "Downloaded"
}

run() {
    echo "Starting solr on port ${SOLR_PORT}..."
    $1/bin/solr start -p ${SOLR_PORT}
}

post_some_documents() {
    java -Dtype=application/json -Durl=http://localhost:$SOLR_PORT/solr/update/json -jar $1/example/exampledocs/post.jar $2
}


download_and_run() {

   
    url="http://archive.apache.org/dist/lucene/solr/8.4.1/solr-8.4.1.tgz"
    dir_name="solr-8.4.1"
    dir_conf="conf/"

    download $url

    # copy schema.xml
    cp -R examples/beapi_conf_example/* $dir_name/example/files/conf/

    # Run solr
    run $dir_name $SOLR_PORT
}

download_and_run
