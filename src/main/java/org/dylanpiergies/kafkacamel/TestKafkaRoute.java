package org.dylanpiergies.kafkacamel;

import org.apache.camel.builder.endpoint.EndpointRouteBuilder;
import org.springframework.stereotype.Component;

@Component
public class TestKafkaRoute extends EndpointRouteBuilder {
  @Override
  public void configure() {
    from(kafka("test-topic"))
        .to(log(getClass().getName()));
  }
}
