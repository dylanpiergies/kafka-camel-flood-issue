# kafka-camel-flood-issue

This project was used to reproduce an issue with the Camel Kafka consumer flooding clients with reconnection attempts
in the scenario where the TCP connection succeeds but the TLS handshake fails.

## Steps to reproduce

1. Generate the certificates:  
   ```shell
   ./gen-certs.sh
   ```

2. Build the test application:
   ```shell
   ./gradlew build
   ```

3. Start the test application:
   ```shell
   ./gradlew bootRun
   ```

   At this point you should see that the client fails to connect, and will retry as per the configured backoff in [the
   application properties](./src/main/resources/application.yml).

4. Start the Kafka broker (**WARNING**: This consumes a lot of resources and can seriously impact system performance.
   You may wish to set up restrictive ulimits and/or save important data before doing this.):
   ```shell
   docker-compose up -d
   ```
   Here we observe the problem where the Kafka broker is flooded with connection attempts.

Changing the configuration property `camel.component.kafka.poll-on-error` to `retry` resolves the issue; the client
still attempts to reconnect, but the backoff configuration is respected.
