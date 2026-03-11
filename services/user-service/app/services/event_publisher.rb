# app/services/event_publisher.rb
require 'bunny'

class EventPublisher
  def self.publish(routing_key, payload)
    # In a production environment, you should reuse the connection
    connection = Bunny.new(hostname: ENV.fetch('RABBITMQ_HOST', 'localhost'))
    connection.start

    channel = connection.create_channel
    # Use a 'topic' exchange for flexibility in routing
    exchange = channel.topic("bank_events", durable: true)

    exchange.publish(
      payload.to_json,
      routing_key: routing_key,
      content_type: 'application/json',
      persistent: true # Ensure the message survives RabbitMQ restarts
    )

    puts " [x] Sent '#{routing_key}': #{payload}"
    
    connection.close
  rescue StandardError => e
    Rails.logger.error "Failed to publish event: #{e.message}"
  end
end