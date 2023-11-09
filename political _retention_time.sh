#!/bin/bash


read -p "Enter the Elasticsearch server IP: " IP
read -p "Enter the amount of time after which documents should be moved to a new index (Example: 15d for 15 days or 20m for 20 minutes): " TIME
    


ILM_RESPONSE=$(curl -s -X PUT "http://${IP}:9200/_ilm/policy/elastiflow" -H 'Content-Type: application/json' -d "
{
  \"policy\": {
    \"phases\": {
      \"delete\": {
        \"min_age\": \"${TIME}\",
        \"actions\": {
          \"delete\": {
            \"delete_searchable_snapshot\": true
          }
        }
      }
    }
  }
}")


if echo "$ILM_RESPONSE" | grep -q "\"acknowledged\":true"; then
  echo "Successfully applied ILM policy!"
else
  echo "Failed to apply ILM policy. Server response: $ILM_RESPONSE"
  exit 1
fi


TEMPLATE_RESPONSE=$(curl -s -X PUT "http://${IP}:9200/_template/default" -H 'Content-Type: application/json' -d '
{
  "index_patterns": ["*"],
  "settings": {
    "number_of_replicas": "0"
  }
}')


if echo "$TEMPLATE_RESPONSE" | grep -q "\"acknowledged\":true"; then
  echo "Template applied successfully!"
else
  echo "Failed to apply the template. Server response: $TEMPLATE_RESPONSE"
  exit 1
fi
