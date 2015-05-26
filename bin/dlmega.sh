#!/bin/bash

ver="1.0";dependencies="awk base64 curl openssl sed xxd";useragent="dlmega/${ver}";curlparams="-LA \"${useragent}\" "
printf "\n dlMEGA, a mega.nz file downloader\n\n" >&2
printf " â€¢ Version ${ver}, free for non-commercial use\n â€¢ Â© 2015 by Herbert Knapp (herbert.knapp$(echo QGVkdS4K | base64 -d 2> /dev/null)uni-graz.at)\n\n" >&2
if [[ ${1} == '' || ${1} == '--help' || ${1} == '-h' ]]; then 
  printf " Usage: $(basename ${0}) [-p --progress-bar] '<MEGA url>' ['<MEGA url>' ... ]\n\n"
  exit 1
fi
for dep in ${dependencies}; do
  if [[ ! -x $(which "${dep}" 2> /dev/null) ]]; then
    echo " ${0}: ${dep} is required" >&2
    exit 1
  fi
done
for url in "${@}"; do
  if [[ ${url} == '--progress-bar' || ${url} == '-p' ]]; then PB="${PB}--progress-bar "; continue; fi
  if [[ ${url} == '-' || ${url} == '--stdout' ]]; then STREAM=1; continue; fi
  id=$(echo "${url}" | awk -F '!' '{print $2}')
  key=$(echo "${url}" | awk -F '!' '{print $3}' | sed -e 's/-/+/g' -e 's/_/\//g' -e 's/,//g')
  if [[ $key == '' ]]; then echo " ${0}: not a MEGA file url: ${url}"; continue; fi
  keydec=$(echo "${key}" | base64 -di 2> /dev/null | xxd -p | tr -d '\n')
  key[0]=$(( 0x${keydec:00:16} ^ 0x${keydec:32:16} ))
  key[1]=$(( 0x${keydec:16:16} ^ 0x${keydec:48:16} ))
  key=$(printf "%016x" ${key[*]})
  iv="${keydec:32:16}0000000000000000"
  api=$(curl -q ${curlparams}-sd '[{"a":"g","g":1,"p":"'$id'"}]' https://eu.api.mega.co.nz/cs)
  dlurl=$(echo "${api}" | awk -F '"' '{print $10}')
  filename=$(echo "${api}" | awk -F '"' '{print $6}' | sed -e 's/-/+/g' -e 's/_/\//g' -e 's/,//g' | base64 -di 2> /dev/null | xxd -p | tr -d '\n' | xxd -p -r | openssl enc -d -aes-128-cbc -K "${key}" -iv 0 -nopad 2> /dev/null | awk -F '"' '{print $4}')
  if [[ -z ${filename} ]]; then echo " ${0}: wrong key in ${url}" >&2; continue; fi
  printf " Filename: ${filename}\n " >&2
  curl -q ${curlparams}${PB}"${dlurl}" | openssl enc -d -aes-128-ctr -K "${key}" -iv "${iv}" > "${filename}" 2> /dev/null
done;
exit 0
