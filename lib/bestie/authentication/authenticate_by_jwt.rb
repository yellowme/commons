module Bestie
  module Authentication
    module AuthenticateByJWT
      def authorize_jwt!
        raise Bestie::Errors::Unauthorized if jwt.blank?

        begin
          decoded = JSONWebToken.decode(jwt)
          @current_user = UserRepository.instance.find_by(id: decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          raise Bestie::Errors::Unauthorized
        rescue JWT::DecodeError => e
          raise Bestie::Errors::Unauthorized
        end
      end

      private

      def jwt
        jwt ||= request.headers['Authorization']
        return nil unless jwt.instance_of? String

        jwt = jwt.split(' ').last if jwt
      end
    end
  end
end
