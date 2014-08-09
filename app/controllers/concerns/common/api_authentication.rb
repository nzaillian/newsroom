module Common
  module ApiAuthentication
    extend ActiveSupport::Concern

    included do
      def authenticate_api_user!
        if User.where(api_key: api_key_param).empty?
          raise CanCan::AccessDenied
        end
      end

      def api_key_param
        params.permit(:api_key)[:api_key]
      end
    end
  end
end