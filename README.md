# Husky challenge!

### Goal
Implement a Russian Doll (or any better strategy) cache for a bank statement receipt

### Description and general information

Imagine that you have a bank statement, with a filter that returns the last 3 days, 15 days, or 30 days data. 

That information is pretty much unchanged from the database entries perspectives: what is paid is paid (debit), amounts credited were credited. There is no reason to query it every single time that you open your banking app. This imaginary banking app is querying all results from the DB every time.

We'd like to have a straightforward way to implement a cache for any entry point of this API that follows similar behavior. This cache "module" should be easily extendable, isolated, and flexible if the business now requires evicts or reloadings of cached data.

### Expected result

1 - We'd like to see a POC, including some Unit tests that prove the chosen cache strategy.

2 - We'd like to see some stress test consuming your API endpoint that serves the bank statement JSON

3 - Memory and cloud storage are currently cheap. We expect you to use a production-ready infrastructure like Memcached or Redis.

4 - An isolated module that we can use as a DSL to evict or include new cache keys reloading current data

5 - Is there a recovery strategy? And if all cached data goes away, how do we query and cache everything back?

6 - You'll explain to the team your approach and defend the pros and cons of your strategy. There is no silver bullet, and we expect that you will be able to explain to us what are the stronger and the weaker points of the chosen strategy.
It should be a piece of code that you studied a little to figure out and are proud of enough to explain to other people.

### Resources
Russian Doll Cache strategy overview on Basecamp: https://youtu.be/ktZLpjCanvg?t=69
https://signalvnoise.com/posts/3690-the-performance-impact-of-russian-doll-caching
