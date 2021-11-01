module Filterable
    extend ApplicationController::Concern
    module Methods
        def filter(criteria)
            result = self.where(nil)
            criteria.each do |key, val|
                result = result.public_send("filter_by_#{key}", value) if value.present
            end
        end
    end
end