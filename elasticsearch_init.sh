#!/bin/bash

while ! curl -sq http://elasticsearchmoloch:9200; do
        echo "Waiting for elastic search to start...";
        sleep 3;
done

echo "Check if elasticsearch is initalized, otherwise do it"
if [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/dstats_v4") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/users_v7") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/fields_v3") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/queries_v3") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/stats_v4") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/sequence_v3") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/hunts_v2") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/files_v6") == *"200*" ]] && \
   [[ ! $(curl -s --head "http://elasticsearchmoloch:9200/lookups_v1") == *"200*" ]]; then
   echo "Initializing elasticsearch..."
   echo "INIT" | /data/moloch/db/db.pl http://elasticsearchmoloch:9200 init
fi

