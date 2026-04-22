## what is redis 

redis is a open source in memory data store, used as cache, database, message broker

## why we use redis ?

it was ultra fast read/write, Reduce DB Load, session storage, Real time apps(chat), Queue system

## pros 

1. very fast, supports multiple data type, easy to use, TTL

## corns

1. data loss risk, expensive for large data, limited complex queries, single threaded

## how Redis store data ?

it store the data in RAM as key-value structure

## How redis Process Data ?

Uses I/O Multiplexing, single threaded event loop, Handles thousands of reuqests efficient without blocking.

## Redis Data types: 

String, List, Set, Sorted Set, Hash, Bitmap, Streams, 

## TTL Time to live 

automatically expire keys

SET user "data"
Expire user 60

## Command Redis commands:

SET key values
GET key
DEL key
EXPIRE key seconds
TTL key

## Optimization Techniques

-> use proper data types
-> use TTL to avoid memory overflow
-> avoid large Kyes/values
-> use connections pooling
-> Enable compressions

## Types of Redis Deployment

-> Standalone
-> Master-Replica
-> Sentinel 
-> Cluster (sharding)

## Alternatives to Redis 

-> memcached (simple caching)
-> Apache cassandra(large scale db)
-> Mongodb (doc storage)
-> Hazelcast (distributed cache)

## When not to use redis 

-> complex Joins/queue
-> large persistent storage needs
-> strong ACID transactional system




