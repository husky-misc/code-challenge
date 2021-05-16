# Responsible to handle auth sessions. ::Api::V1::AuthController

module Api
  module V1
    class AuthController < ::Api::V1::ApiController
      before_action :authorized, only: [:auto_login]

      def create
        @user = ::User.find_by(email: params[:email])

        if @user&.authenticate(params[:password])
          token = encode_token({ user_id: @user.id })

          render_create({ user: @user, token: token })
        else
          render_error_message('Invalid username or password!', :unauthorized)
        end
      end

      def auto_login
        render json: @user
      end
    end
  end
end
