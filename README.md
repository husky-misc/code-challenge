# ip-log-parser / Ruby challenge!

Challenge: Create an API that receives, store and compute 7-bit ASCII text.

First part: Create an endpoint `/store` that receives and store 7-bit ASCII text. Each request, should include a data line that may consist of an IP address, followed by a colon, followed by a comma-separated list of numbers. Feel free to design the submmited JSON as your back-end object should look like.

Second part: This API should also have an endpoint called `/compute`. When requested, all available data submitted should be joined on IP address format and the numbers from each stored data should be appended and returned, sorted and without duplicates. The results should be send as the IP address followed by a colon, followed by a comma separated list of the numbers as JSON.

For example, request-1 may contain these data:
```
curl -i -X POST "http://localhost:3000/api/v1/store" -H "Authorization: jVbwTGNy9u5MZpLCoLYV3JR9" \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
  "ip_list": [
      "1.2.3.4: 1,3,4",
      "1.2.3.5: 9,8,7,6"      
  ]
}'
```

And request-2:
```
curl -i -X POST "http://localhost:3000/api/v1/store" -H "Authorization: jVbwTGNy9u5MZpLCoLYV3JR9" \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
  "ip_list": [
      "1.2.3.4: 4,5,6",
      "1.2.3.6: 1,1,1"
  ]
}'
``` 

At this point, if I request `GET /compute`, the JSON return should have the data:
```
data: {
  "ip_code": [
     "1.2.3.4": "1,3,4,5,6",
     "1.2.3.5": "6,7,8,9",
     "1.2.3.6": "1"
  ]
}
```
