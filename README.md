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

3. Start the Kafka broker:
   ```shell
   docker-compose up
   ```
   Here we observe the problem where the Kafka broker is flooded with connection attempts.

4. Start the test application  (**WARNING**: This can consume a lot of resources):
   ```shell
   ./gradlew bootRun
   ```

You should see the Camel application will reconnect in a tight loop.

Changing the configuration property `camel.component.kafka.poll-on-error` to `retry` resolves the issue; the client
still attempts to reconnect, but the backoff configuration is respected.
