class Story
  module Filtering
    extend ActiveSupport::Concern

    included do
      scope :filter, ->(filters){
        filters ||= {}
        
        items = all

        if filters[:starred].present?
          items = items.where(starred: filters[:starred])
        end

        items
      }
    end
  end
end