# CERVEJATOR

## What is it?

Cervejator is an online IoT device control an monitor application.

## How does it work?

You create your devices (sensors and actuators) and get a WRITE\_KEY. This key
is used for communication between device and platform (see currently supported
protocols below)

## Supported Protocols

Currently only MQTT is supported, you can either run your own MQTT broker (see
[docker-mosquitto](https://github.com/toke/docker-mosquitto) for a dockeriezed
broker) or use one of the many free online brokers available online.

## USAGE

We use docker-compose to spin up all components of the application, see the
docker-compose.yml file for more details.

## To include in this document:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
