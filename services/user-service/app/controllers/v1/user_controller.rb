class V1::UserController < ApplicationController
    def create
        # Check for Idempotency-Key (Header)
        # For simplicity in this first step, we check uniqueness in DB,
        # but a robust system would store the key in Redis/DB.
        user = User.new(user_params)

        if user.save
          render json: { id: user.id, username: user.username }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:username)
      end
end
