# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

Random partitioning distributes observations evenly across all boats, which helps balance the load and prevents any single server from becoming overloaded. However, because observations are assigned randomly, queries that search for a range of timestamps must run on all boats. This can make queries slower and less efficient.

## Partitioning by Hour

Partitioning by hour makes it easy to locate observations within a specific time range, since all data from the same time period is stored on the same boat. This improves the speed of time-based queries. However, if most observations occur during a specific time period, one boat may receive significantly more data than the others, leading to poor load balancing and possible server overload.

## Partitioning by Hash Value

Hash partitioning distributes observations evenly across boats because the hash function spreads timestamps uniformly. This helps maintain good load balancing across the system. However, range queries are inefficient because observations within a time range may be stored on different boats, requiring the query to run on all servers.
