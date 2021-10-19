#!/bin/bash

## Make sure there are environment variables for umls username and password
if [ -z $umls_api_key ] ; then
   echo "Environment variable umls_api_key must be defined"
   exit 1
fi

export ctakes_umlsuser=umls_api_key

export ctakes_umlspw=$umls_api_key

## Pass in environment variables
docker run -p 8080:8080 -e ctakes_umlsuser -e ctakes_umlspw -d ctakes-web-rest

