#!/bin/bash

echo 'benchmarking with cache..'
CACHE_ENABLED=true bin/rails s & > bench.log 2> bench_error.log
sleep 5
ab -n 1000 -c 10 -l "http://localhost:3000/bank_statement?account_id=1145&filter_days=15"
kill $!

echo '==============='

# echo 'benchmarking without cache..'
# rm -f tmp/caching-dev.txt

# bin/rails s & > bench.log 2> bench_error.log

# sleep 5
# ab -n 1000 -c 10 -l "http://localhost:3000/bank_statement?account_id=1145&filter_days=15"
# kill $!
