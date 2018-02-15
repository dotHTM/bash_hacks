#!/usr/local/bin/bash

searchlist='\\bscu+k?\\b
nsfw
lewd
nude
\\btit
dick
pussy
\\bvag
\\bporn
Burlesque
pinup
camgirl
18\\+'

timeline_path="files/stream.csv"
profilecache_path="files/profiles.csv"

out_timeline_path="files/found_stream.csv"
out_profilecache_path="files/found_profiles.csv"
out_joined_path="files/found_join.csv"

t followings -c > ${profilecache_path}

head -n 1 ${timeline_path} > ${out_timeline_path} 
head -n 1 ${profilecache_path} > ${out_profilecache_path} 


for searchWord in $searchlist; do
    ./csv_search.pl -f ${timeline_path} -s ${searchWord} --csv-output >> ${out_timeline_path}
    ./csv_search.pl -f ${profilecache_path} -s "${searchWord}" --csv-output >> ${out_profilecache_path}
done


joinedFile(){
cat ${out_timeline_path} | uniq
echo
cat ${out_profilecache_path} | uniq
}

joinedFile > ${out_joined_path}


