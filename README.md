# Husky dev Ruby challenge!

### Description and general information

Create an API that receives, store and compute 7-bit ASCII text. This text will consist in a IP, followed by a column and a sequence of numbers. i.e `127.0.0.1:0,11,23,44,50`.

### Requirements

- This API should be JSON only. That means that this API only accepts requests as `Content-Type: application/json; charset=utf-8`. Requests in any other format should Return `415 Unsupported Media Type`

- You should return a 415 Unsupported Media Type response code if the consumer attempt to use a different URL suffix or leave out the Content-Type header.

- Your program should handle errors, including malformed input, appropriately and should be of a sufficient quality that it can run on a production Linux system. 

- It may include deployment instructions depending on wich technology you decide to use. 

- Follow Restful principles when design your API.

### Endpoints and expected behavior

#1: Create an endpoint `/store` that receives and store 7-bit ASCII text. Each request, should include a data line that may consist of an IP address, followed by a colon, followed by a comma-separated list of numbers. Feel free to design the submmited JSON as your back-end object should look like.

#2: This API should also have an endpoint called `/compute`. When requested, all available data submitted until this request should be joined on IP address format and the numbers from each stored data should be appended and returned, sorted and without duplicates. The results should be send as the IP address followed by a colon, followed by a comma separated list of the numbers as JSON.

For example, request-1 may store these data:
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

And request-2 store these other data:
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

At this point, if I request `/compute`, the JSON return should have the data:
```
data: {
  "ip_code": [
     "1.2.3.4": "1,3,4,5,6",
     "1.2.3.5": "6,7,8,9",
     "1.2.3.6": "1"
  ]
}
```

Important: 
- All `/store` data existing until the `/compute` call should be flushed after computing.
- Make sure to cover your code (test suite).
- You should submit a PR not late 5 days after fork this repository.
- You may use any ruby framework or lib of your preference. This code should be concise, small and well tested. We recommend small framerworks like `sinatra`, `grape`, `rails-api` and so on. Please, don't create a full rails application.

### Optional requirements

It may count extra points on your evaluation. It's not obligated althougth it's really appreciatted by our team.

- Store and create an endpoint to return all previous results from `/compute`.
- Enable pagination (5 per request) when return previous results from `/compute`.
- Create an `Authorization` Header or API keys to ensure that only authorized users request data on your API.
- Deploy it at any free cloud service so we don't need to deploy ourselves in order to test your code.
- Create an admin page where the user can see the computed ips trougth `/compute` including when it was computed and so on.
