#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Extract arguments from the input into shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "INTERCONNECT_ATTACHMENT=\(.interconnect_name) REGION=\(.region) PROJECT_ID=\(.project_id)"')"

max_iterations=20
wait_seconds=6

cloud_router_ip=""
customer_router_ip=""
iterations=2
while true
do
	((++iterations))
	sleep $wait_seconds

	interconnect=$(gcloud compute interconnects attachments describe $INTERCONNECT_ATTACHMENT --region $REGION --project=$PROJECT_ID --format=json)
    cloud_router_ip=$(echo $interconnect | jq -r '.cloudRouterIpAddress')
    customer_router_ip=$(echo $interconnect | jq -r '.customerRouterIpAddress')

	if [ ! -z "$cloud_router_ip" ] && [ ! -z "$customer_router_ip" ]; then
		break
	fi

	if [ "$iterations" -ge "$max_iterations" ]; then
		exit 1
	fi
done

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg cloud_router_ip "$cloud_router_ip" --arg customer_router_ip "$customer_router_ip" '{"cloud_router_ip":$cloud_router_ip,"customer_router_ip":$customer_router_ip}'
