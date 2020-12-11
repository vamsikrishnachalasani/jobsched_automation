#!/usr/bin/bash
 
# -----------------------------------------
# MODIFY FOR YOUR ENVIRONMENT
 
# Protocol, host and port of JOC Cockpit
JS_URL="https://internal-jobsched-gui-lb-poc-1675361362.us-west-2.elb.amazonaws.com/joc/"
 
# Identification of JobScheduler instance
JS_ID="testsuite"
 
# Path and name of Job Chain
JS_JOB_CHAIN="/sos/*"
 
# Path and name of Job
JS_JOB="/sos/*"
 
# Base64 encoded string "user:password" for JOC Cockpit authentication. The below string represents "root:root"
JS_BASIC_AUTHENTICATION="`echo "root:root" | base64`"
JS_BASIC_AUTHENTICATION="${JS_BASIC_AUTHENTICATION:0:${#JS_BASIC_AUTHENTICATION}-4}"
# -----------------------------------------
 
 
# -----------------------------------------
# Perform login
echo ""
echo "PERFORMING LOGIN"
JS_JSON="`curl -k -s -S -X POST -i -m 15 -H "Authorization: Basic $JS_BASIC_AUTHENTICATION" -H "Accept: application/json" -H "Content-Type: application/json" $JS_URL/joc/api/security/login`"
JS_ACCESS_TOKEN=$(echo $JS_JSON | grep -Po '"accessToken":.*?[^\\]"' | awk -F ':' '{print $2}' | tr -d \" )
# -----------------------------------------
 
 
# -----------------------------------------
# Get the status of a job chain
echo ""
echo "Get the status of a job chain"
# Execute web service request
JS_REST_BODY="{ \"jobschedulerId\": \"$JS_ID\", \"compact\": true, \"jobChain\": \"$JS_JOB_CHAIN\" }"
JS_JSON="`curl -k -s -S -X POST -d "$JS_REST_BODY" -i -m 15 -H "X-Access-Token: $JS_ACCESS_TOKEN" -H "Accept: application/json" -H "Content-Type: application/xml" $JS_URL/joc/api/job_chain`"
echo $JS_JSON
# -----------------------------------------
 
 
# -----------------------------------------
# Get the status of a job
echo ""
echo "Get the status of a job"
# Execute web service request
JS_REST_BODY="{ \"jobschedulerId\": \"$JS_ID\", \"compact\": true, \"job\": \"$JS_JOB\" }"
JS_JSON="`curl -k -s -S -X POST -d "$JS_REST_BODY" -i -m 15 -H "X-Access-Token: $JS_ACCESS_TOKEN" -H "Accept: application/json" -H "Content-Type: application/xml" $JS_URL/joc/api/job`"
echo $JS_JSON
# -----------------------------------------
 
 
# -----------------------------------------
# Perform logout
echo ""
echo "PERFORMING LOGOUT"
curl -k -s -S -X POST -i -m 15 -H "X-Access-Token: $JS_ACCESS_TOKEN" -H "Accept: application/json" -H "Content-Type: application/json" $JS_URL/joc/api/security/logout
# -----------------------------------------
echo ""
