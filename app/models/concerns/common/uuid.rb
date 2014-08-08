module Common
  module Uuid
    extend ActiveSupport::Concern

    included do
      before_validation :generate_uuid, on: :create

      private

      def generate_uuid(opts={})
        if uuid.blank? || opts[:force] == true
          self.uuid = loop do
            random_uuid = SecureRandom.hex(5)
            break random_uuid unless self.class.where(uuid: random_uuid).exists?
          end
        end
      end
    end
  end
end