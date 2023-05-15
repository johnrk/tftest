#!/bin/bash

# Triggers a cloud scan for tftest


curl -X POST \
'https://api.snyk.io/rest/orgs/34c8f01d-ae1a-423d-a205-6eff50be87a6/cloud/scans?version=2023-03-08~beta' \
-H "Authorization: token $SNYK_TOKEN" \
-H "Content-Type:application/vnd.api+json"  -d '{
  "data": {
    "relationships": {
      "environment": {
        "data": {
          "id": "3b37a615-97dd-466f-ba2e-91aac91a032a",
          "type": "environment"
        }
      }
    },
    "type": "resource"
  }
}' | jq '.'