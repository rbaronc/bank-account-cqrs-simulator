# app/models/user.rb
class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
  
    # After creating the user, we notify the rest of the system
    after_commit :broadcast_user_created, on: :create
  
    private
  
    def broadcast_user_created
      # This is a placeholder for the RabbitMQ Publisher we'll build
      EventPublisher.publish('user.created', { 
        user_id: self.id, 
        username: self.username 
      })
    end
  end