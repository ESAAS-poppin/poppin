module Filterable
    extend ActiveSupport::Concern
    module Methods
        def filter(criteria)
            result = self.where(nil)
            criteria.each do |key, value|
                result = result.public_send("filter_by_#{key}", value) if value.present
            end
            results
        end
    end
end